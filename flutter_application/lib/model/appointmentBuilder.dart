import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/eventView.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Events.dart';
import 'package:intl/intl.dart';

Widget appointmentBuilder(BuildContext context,
    CalendarAppointmentDetails details, CalendarController controller) {
  final Event event = details.appointments.first;

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventViewPage(event: event),
        ),
      );
    },
    child: Container(
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
            if (controller.view != CalendarView.week)
              customText(event.subject, 14),
            if (controller.view == CalendarView.month)
              customText(
                  '${DateFormat.jm().format(event.startTime)} - ${DateFormat.jm().format(event.endTime)}',
                  14),
            if (event.description != null &&
                controller.view == CalendarView.day)
              customText(event.description!, 12)
          ],
        ),
      ),
    ),
  );
}

Text customText(String text, double fontSize) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    ),
  );
}
