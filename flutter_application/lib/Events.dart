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

class _EventDataSource extends CalendarDataSource {
  _EventDataSource(List<Event> source) {
    appointments = source;
  }

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
    return appointments![index].subject;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}

  // Widget appointmentBuilder(BuildContext context, CalendarAppointmentDetails details) {
  //   final Event event = details.appointments.first;

  //   return Container(
  //     width: details.bounds.width,
  //     height: details.bounds.height,
  //     decoration: BoxDecoration(
  //       color: event.color.withOpacity(0.5),
  //       border: Border.all(
  //         color: event.color,
  //         width: 2,
  //       ),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           '${DateFormat.jm().format(event.startTime)} - ${DateFormat.jm().format(event.endTime)}',
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 12,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           event.subject,
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }