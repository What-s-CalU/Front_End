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

Widget appointmentBuilder(BuildContext context, CalendarAppointmentDetails details, CalendarController controller) {
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
        if (controller.view == CalendarView.month)
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
