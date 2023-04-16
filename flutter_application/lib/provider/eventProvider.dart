import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Events.dart';
import '../model/EventCategory.dart';
import '../model/User.dart';

class EventProvider extends ChangeNotifier {
  //events
  final List<Event> _events = [];
  List<Event> get events => _events;

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

  void removeEventsByCategory(int categoryID) {
    _events.removeWhere((event) => event.categoryID == categoryID);
    _categories.removeWhere((category) => category.id == categoryID);
    notifyListeners();
  }

  List<Event> getEventsByCategory(String categoryName) {
    return _events.where((event) {
      EventCategory category = findCategoryById(event.categoryID!);
      return category.name == categoryName;
    }).toList();
  }

  int getNumberOfEventsByCategory(int categoryID) {
    return _events.where((event) => event.categoryID == categoryID).length;
  }

  List<Event> getEventsByDaysAway(int daysAway) {
    DateTime now = DateTime.now();
    DateTime startRange = DateTime(now.year, now.month, now.day);
    DateTime endRange = startRange.add(Duration(days: daysAway));

    return _events.where((event) => event.startTime.isAfter(startRange) && event.startTime.isBefore(endRange)).toList();
  }

  void updateEvent(Event updatedEvent) {
    final int index = events.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      events[index] = updatedEvent;
      notifyListeners();
    }
  }


  //categories
  final List<EventCategory> _categories = [];

  void addCategories(List<EventCategory> categoriesToAdd) {
    _categories.addAll(categoriesToAdd);
    notifyListeners();
  }

  void addCategory(EventCategory category) {
    _categories.add(category);
    notifyListeners();
  }

  String getCategoryNameById(int id) {
    for (EventCategory category in _categories) {
      if (category.id == id) {
        return category.name;
      }
    }
    return '';
  }

  Color getCategoryColorById(int id) {
    for (EventCategory category in _categories) {
      if (category.id == id) {
        return category.color;
      }
    }
    return Colors.blue;
  }

  int? getCategoryUserIdById(int id) {
    for (EventCategory category in _categories) {
      if (category.id == id) {
        return category.userID;
      }
    }
    return null;
  }

  List<EventCategory> getCustomEventCategories() {
    return _categories.where((category) => category.userID != null).toList();
  }

  List<EventCategory> getCaluEventCategories() {
    return _categories.where((category) => category.userID == null).toList();
  }

  EventCategory findCategoryById(int categoryId) {
    return _categories.firstWhere((category) => category.id == categoryId);
  }

  //user TODO
  final User _user = User(id: null, name: "", checksum: "");
  User get user => _user;


  void logout(){
    _events.clear();
    _categories.clear();
    _user.setnull();
  }


  bool isNotCustomCategory(int? categoryID) {
    if (categoryID == null) {
      return false;
    }
    return !_events.any((event) => event.isCustom && event.categoryID == categoryID);
  }

}