import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_application_1/model/Events.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';

class EventDataSource extends CalendarDataSource {
  final EventProvider _eventProvider;

  EventDataSource(List<Event> appointments, this._eventProvider) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return _eventProvider.getCategoryColorById(appointments![index].categoryID!);
  }

  String getDescription(int index) {
    return appointments![index].description;
  }

  String? getCategory(int index) {
    return _eventProvider.getCategoryNameById(appointments![index].categoryID!);
  }

  bool getIsCustom(int index) {
    return appointments![index].isCustom;
  }
}