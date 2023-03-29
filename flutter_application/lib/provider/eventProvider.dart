import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Events.dart';
import '../model/categoryColorMapping.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void removeEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  List<String> getCustomEventCategories() {
    return _events
        .where((event) => event.isCustom == true && event.category != null)
        .map((event) => event.category!)
        .toSet()
        .toList();
  }

  List<String> getCaluEventCategories() {
    return _events
        .where((event) => event.isCustom == false && event.category != null)
        .map((event) => event.category!)
        .toSet()
        .toList();
  }

  List<Event> getEventsByCategory(String category) {
    return _events.where((event) => event.category == category).toList();
  }

  List<Event> getEventsByDaysAway(int daysAway) {
    DateTime now = DateTime.now();
    DateTime startRange = DateTime(now.year, now.month, now.day);
    DateTime endRange = startRange.add(Duration(days: daysAway));

    return _events
        .where((event) =>
            event.startTime.isAfter(startRange) &&
            event.startTime.isBefore(endRange))
        .toList();
  }

  final CategoryColorMapping _categoryColorMapping = CategoryColorMapping();

  CategoryColorMapping get categoryColorMapping => _categoryColorMapping;

  void addCustomEventCategory(String category, Color color) {
    _categoryColorMapping.setColorForCategory(category, color);
    notifyListeners();
  }

  bool isNotCustomCategory(String? category) {
    if (category == null) {
      return false;
    }
    return !_events
        .any((event) => event.isCustom && event.category == category);
  }
}
