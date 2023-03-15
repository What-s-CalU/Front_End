import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/LoginPageUtil.dart';
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

Padding textBeforeTextField(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
    child: Text(text),
  );
}

Padding dateInputField(TextEditingController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: TextField(
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
              String formattedDate = DateFormat("MM/dd/yyyy").format(pickedDate);
              controller.text = formattedDate.toString();
            }
          },
          child: const Icon(Icons.calendar_month),
        ),
        hintText: "Date",
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

TextField timeInputField(TextEditingController controller, BuildContext context, String hint) {
  return TextField(
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
  );
}

Padding descriptionTextField(BuildContext context, TextEditingController controller) {
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

Widget timeInputFields(TextEditingController fromController, TextEditingController toController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: timeInputField(fromController, context, "From"),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: timeInputField(toController, context, "To"),
        )),
      ],
    ),
  );
}

Widget buildColorDropdownButton(List<Color> colors, Color selectedColor, ValueChanged<Color?> onChanged) {
  // Define a list of DropdownMenuItem widgets based on the provided colors
  List<DropdownMenuItem<Color>> colorItems = colors.map((color) {
    return DropdownMenuItem<Color>(
      value: color,
      child: Container(
        width: 30,
        height: 30,
        color: color,
      ),
    );
  }).toList();

  // Create the dropdown button widget
  return DropdownButton<Color>(
    value: selectedColor,
    items: colorItems,
    onChanged: onChanged,
  );
}
