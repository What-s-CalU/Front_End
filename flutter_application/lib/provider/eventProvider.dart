import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Events.dart';
import '../model/categoryColorMapping.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  final CategoryColorMapping _categoryColorMapping = CategoryColorMapping();

  String _username = '';

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  CategoryColorMapping get categoryColorMapping => _categoryColorMapping;

  List<Event> get events => _events;

  void logout(){
    _events.clear();
    _username = '';
    _categoryColorMapping.removeColorsForCategories();
  }

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void addEvents(List<Event> eventsToAdd) {
    _events.addAll(eventsToAdd);
    notifyListeners();
  }

  void removeEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void removeEventsByCategory(String category) {
    _events.removeWhere((event) => event.category == category);
    notifyListeners();
  }

  List<String> getCustomEventCategories() {
    return _events.where((event) => event.isCustom == true && event.category != null).map((event) => event.category!).toSet().toList();
  }

  List<String> getCaluEventCategories() {
    return _events.where((event) => event.isCustom == false && event.category != null).map((event) => event.category!).toSet().toList();
  }

  List<Event> getEventsByCategory(String category) {
    return _events.where((event) => event.category == category).toList();
  }

  List<Event> getEventsByDaysAway(int daysAway) {
    DateTime now = DateTime.now();
    DateTime startRange = DateTime(now.year, now.month, now.day);
    DateTime endRange = startRange.add(Duration(days: daysAway));

    return _events.where((event) => event.startTime.isAfter(startRange) && event.startTime.isBefore(endRange)).toList();
  }

    int getNumberOfEventsByCategory(String category) {;

    return _events.where((event) {
      return event.category == category;
    }).length;
  }

  void addCustomEventCategory(String category, Color color) {
    _categoryColorMapping.setColorForCategory(category, color);
    notifyListeners();
  }

  bool isNotCustomCategory(String? category) {
    if (category == null) {
      return false;
    }
    return !_events.any((event) => event.isCustom && event.category == category);
  }

  void setColorsForCategories(List<Event> events) {
    for (Event event in events) {
      if (categoryColorMapping.getColorForCategory(event.category) == Colors.blue) {
        categoryColorMapping.setColorForCategory(event.category!, event.color);
      }
    }
  }

}