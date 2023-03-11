import 'package:flutter/material.dart';

class Event {
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;

  Event({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.color,
  });
}

class EventsModel extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  set events(List<Event> events) {
    _events = events;
    notifyListeners();
  }

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
}
