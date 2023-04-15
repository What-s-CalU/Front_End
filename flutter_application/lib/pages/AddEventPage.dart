import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Category.dart';
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

  int? _selectedCategory;
  final _formKey = GlobalKey<FormState>();

  Color mainColor = const Color(0xff083c74);

  void _onCategoryChanged(int? newCategory) {
    _selectedCategory = newCategory;
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('ADD EVENT'),
        centerTitle: true,
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      
                      await sendAddCustomEvent(
                        eventProvider.username, 
                        convertStringsToDateTime(_dateController.text, _fromTimeController.text),
                        convertStringsToDateTime(_dateController.text, _toTimeController.text),
                        _titleController.text,
                        _descriptionController.text,
                        _selectedCategory,
                        eventProvider
                      );

                        Navigator.pop(context);

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
