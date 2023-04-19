import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/eventView.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../provider/eventProvider.dart';
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
        color: Provider.of<EventProvider>(context, listen: false).getCategoryColorById(event.categoryID!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.view != CalendarView.week && controller.view != CalendarView.day)
              customText(event.title, 15, controller.view),
            if (controller.view == CalendarView.day)
              customText(event.title, 12, controller.view),
            if (controller.view == CalendarView.month || controller.view == CalendarView.schedule)
              customText(
                  '${DateFormat.jm().format(event.startTime)} - ${DateFormat.jm().format(event.endTime)}',
                  15, controller.view),
          ],
        ),
      ),
    ),
  );
}

Flexible customText(String text, double fontSize, CalendarView? view) {
  return Flexible(
    fit: FlexFit.loose,
    child: Text(
      text,
      overflow: (view == CalendarView.month || view == CalendarView.schedule) ? TextOverflow.ellipsis : null, // Conditional overflow
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}