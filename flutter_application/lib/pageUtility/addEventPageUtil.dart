import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/LoginPageUtil.dart';
import 'package:intl/intl.dart';

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

Padding textBeforeTextField(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
    child: Text(text),
  );
}

Padding timeInputFields(TextEditingController fromController,
    TextEditingController toController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: timeInputField(
            fromController,
            context,
            "From",
            (value) => validateTime(value, toController.text, context),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: timeInputField(
            toController,
            context,
            "To",
            (value) => validateTime(fromController.text, value, context),
          ),
        )),
      ],
    ),
  );
}

TextFormField buildTitleTextField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      hintText: "Title",
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a title';
      }
      return null;
    },
  );
}

Padding dateInputField(TextEditingController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat("MM/dd/yyyy").format(pickedDate);
              controller.text = formattedDate.toString();
            }
          },
          child: const Icon(Icons.calendar_month),
        ),
        hintText: "Date",
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }

        final format = DateFormat("MM/dd/yyyy");
        try {
          format.parse(value);
        } catch (e) {
          return 'Invalid date format';
        }

        return null;
      },
    ),
  );
}

TextFormField timeInputField(TextEditingController controller,
    BuildContext context, String hint, String? Function(String?) validator) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: GestureDetector(
        onTap: () async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (time != null) {
            controller.text = time.format(context);
          }
        },
        child: const Icon(Icons.timer),
      ),
      hintText: hint,
      border: const OutlineInputBorder(),
    ),
    validator: validator,
  );
}

Padding descriptionTextField(
    BuildContext context, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: Stack(
      children: [
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Description",
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: mainColor,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Close the keyboard
              FocusScope.of(context).unfocus();
              // Handle send button press
            },
          ),
        ),
      ],
    ),
  );
}

String? validateTime(
    String? fromTimeValue, String? toTimeValue, BuildContext context) {
  if (fromTimeValue == null || fromTimeValue.isEmpty) {
    return 'Please select a time';
  }

  if (toTimeValue == null || toTimeValue.isEmpty) {
    return null;
  }

  final format = DateFormat("hh:mm a");
  DateTime? fromTime;
  DateTime? toTime;

  try {
    fromTime = format.parse(fromTimeValue);
  } catch (e) {
    return 'Invalid time format';
  }

  try {
    toTime = format.parse(toTimeValue);
  } catch (e) {
    return 'Invalid time format';
  }

  if (fromTime.isAfter(toTime)) {
    return 'From must be before to';
  }

  return null;
}
