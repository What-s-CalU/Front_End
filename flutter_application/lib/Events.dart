import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }
}

Widget appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) {
  final Event event = details.appointments.first;

  return Container(
    width: details.bounds.width,
    height: details.bounds.height,
    decoration: BoxDecoration(
      color: event.color.withOpacity(0.5),
      border: Border.all(
        color: event.color,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${DateFormat.jm().format(event.startTime)} - ${DateFormat.jm().format(event.endTime)}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          event.subject,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

List<Event> events = [
  Event(
    startTime: DateTime(2023, 3, 15, 10),
    endTime: DateTime(2023, 3, 15, 12),
    subject: 'Meeting with John',
    color: Colors.blue,
  ),
  Event(
    startTime: DateTime(2023, 3, 16, 14),
    endTime: DateTime(2023, 3, 16, 16),
    subject: 'Presentation with Team',
    color: Colors.red,
  ),
  Event(
    startTime: DateTime(2023, 3, 17, 9),
    endTime: DateTime(2023, 3, 17, 11),
    subject: 'Call with Client',
    color: Colors.green,
  ),
];
