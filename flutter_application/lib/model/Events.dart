import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Event {
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;
  final String? description;

  Event({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.color,
    this.description,
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
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.subject,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (controller.view == CalendarView.month)
            Text(
              '${DateFormat.jm().format(event.startTime)} - ${DateFormat.jm().format(event.endTime)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (event.description != null && controller.view == CalendarView.day)
            Text(
              event.description!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
        ],
      ),
    ),
  );
}
