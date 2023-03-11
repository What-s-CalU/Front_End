import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HomePage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Events.dart';
import 'package:provider/provider.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _ToTimeController = TextEditingController();
  final TextEditingController _ToDateController = TextEditingController();
  final TextEditingController _FromTimeController = TextEditingController();
  final TextEditingController _FromDateController = TextEditingController();
  final TextEditingController _TitleController = TextEditingController();
  Color mainColor = const Color(0xff083c74);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 5),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Title", border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Text("From"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _FromDateController,
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
                        _FromDateController.text = formattedDate.toString();
                      }
                    },
                    child: const Icon(Icons.calendar_month),
                  ),
                  hintText: "Date",
                  border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _FromTimeController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (time != null) {
                        setState(() {
                          _FromTimeController.text = time.format(context);
                        });
                      }
                    },
                    child: const Icon(Icons.timer),
                  ),
                  hintText: "Time",
                  border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Text("To"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _ToDateController,
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
                        _ToDateController.text = formattedDate.toString();
                      }
                    },
                    child: const Icon(Icons.calendar_month),
                  ),
                  hintText: "Date",
                  border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _ToTimeController,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (time != null) {
                        setState(() {
                          _ToTimeController.text = time.format(context);
                        });
                      }
                    },
                    child: const Icon(Icons.timer),
                  ),
                  hintText: "Time",
                  border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Text("Description"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: mainColor))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () {
                  Event newEvent = Event(
                    startTime: DateTime(2022, 3, 15, 10, 0, 0),
                    endTime: DateTime(2022, 3, 15, 11, 0, 0),
                    subject: 'New Event',
                    color: Colors.blue,
                  );
                  //if return correct event add it and return to home page
                  final eventsModel =
                      Provider.of<EventsModel>(context, listen: false);
                  eventsModel.addEvent(newEvent);
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
