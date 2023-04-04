import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/addEventPageUtil.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';
import '../httpRequests/httpRequests.dart';
import '../model/Events.dart';
import '../pageUtility/categoryDropdown.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _toTimeController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedCategory;
  final _formKey = GlobalKey<FormState>();

  Color mainColor = const Color(0xff083c74);

  void _onCategoryChanged(String? newCategory) {
    _selectedCategory = newCategory;
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 5),
              child: buildTitleTextField(_titleController),
            ),
            dateInputField(_dateController, context),
            textBeforeTextField("Time"),
            timeInputFields(_fromTimeController, _toTimeController, context),
            descriptionTextField(context, _descriptionController),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
              child: CategoryDropdown(
                onCategoryChanged: _onCategoryChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      Event newEvent = Event(
                        startTime: convertStringsToDateTime(
                            _dateController.text, _fromTimeController.text),
                        endTime: convertStringsToDateTime(
                            _dateController.text, _toTimeController.text),
                        subject: _titleController.text,
                        color: eventProvider.categoryColorMapping
                            .getColorForCategory(_selectedCategory),
                        description: _descriptionController.text,
                        isCustom: true,
                        category: _selectedCategory,
                      );
                      int response = await sendAddCustomEvent(
                        eventProvider.username,
                        newEvent.startTime,
                        newEvent.endTime,
                        newEvent.subject,
                        newEvent.color,
                        newEvent.description,
                        newEvent.category,
                      );

                      if (response == 200) {
                        // If the response is successful, add the event and return to the home page
                        final provider =
                            Provider.of<EventProvider>(context, listen: false);
                        provider.addEvent(newEvent);
                        Navigator.pop(context);
                      } else {
                        print("Error adding custom event: Status code $response");
                      }
                    }
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
      ),
    );
  }
}
