import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/addEventPageUtil.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/Events.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _toTimeController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Color> colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
  ];
  Color selectedColor = Colors.blue;
  Color mainColor = const Color(0xff083c74);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          buildTitleTextField(_titleController),
          dateInputField(_dateController, context),
          textBeforeTextField("Time"),
          timeInputFields(_fromTimeController, _toTimeController, context),
          descriptionTextField(context, _descriptionController),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: buildColorDropdownButton(colorOptions, selectedColor, (color) {
              setState(() {
                selectedColor = color!;
              });
            }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Event newEvent = Event(
                      startTime: convertStringsToDateTime(_dateController.text, _fromTimeController.text),
                      endTime: convertStringsToDateTime(_dateController.text, _toTimeController.text),
                      subject: _titleController.text,
                      color: selectedColor,
                      description: _descriptionController.text,
                    );
                    //if return correct event add it and return to home page
                    final provider = Provider.of<EventProvider>(context, listen: false);
                    provider.addEvent(newEvent);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(backgroundColor: mainColor),
                  child: const Text(
                    'ADD EVENT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
