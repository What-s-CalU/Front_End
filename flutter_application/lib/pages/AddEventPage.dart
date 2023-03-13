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
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
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
          textBeforeTextField("FROM"),
          dateInputField(_fromDateController, context),
          timeInputField(_fromTimeController, context),
          textBeforeTextField("TO"),
          dateInputField(_toDateController, context),
          timeInputField(_toTimeController, context),
          textBeforeTextField("DESCRIPTION"),
          descriptionTextField(),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Event newEvent = Event(
                    startTime: convertStringsToDateTime(_fromDateController.text, _fromTimeController.text),
                    endTime: convertStringsToDateTime(_toDateController.text, _toTimeController.text),
                    subject: _titleController.text,
                    color: Colors.blue,
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
        ],
      ),
    );
  }
}
