import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildTitleTextField(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 20, 40, 5),
    child: TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: "Title",
        border: OutlineInputBorder(),
      ),
    ),
  );
}

DateTime convertStringsToDateTime(String date, String time) {
  // Split the date string into its components
  List<String> dateParts = date.split('/');
  int month = int.parse(dateParts[0]);
  int day = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);

  // Parse the time string into an hour and minute using DateFormat
  final format = DateFormat("hh:mm a");
  final dateTime = format.parse(time);
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  // Create a DateTime object with the date and time components
  return DateTime(year, month, day, hour, minute);
}
