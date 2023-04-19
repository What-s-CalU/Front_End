import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/addEventPageUtil.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../httpRequests/httpRequests.dart';
import '../model/Events.dart';
import '../pageUtility/categoryDropdown.dart';

class AddEventPage extends StatefulWidget {
  final Event? event;
  final Function(Event)? onUpdateEvent;

  const AddEventPage({Key? key, this.onUpdateEvent, this.event}) : super(key: key);

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
    void initState() {
      super.initState();
      if (widget.event != null) {
        _toTimeController.text = DateFormat.jm().format(widget.event!.endTime);
        _fromTimeController.text = DateFormat.jm().format(widget.event!.startTime);
        _dateController.text = DateFormat.yMd().format(widget.event!.startTime);
        _titleController.text = widget.event!.title;
        _descriptionController.text = widget.event!.description ?? "";
        _selectedCategory = widget.event!.categoryID;
      }
    }

 @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.event == null ? 'ADD EVENT' : 'EDIT EVENT'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 5),
              child: buildTitleTextField(_titleController, editable: widget.event?.isCustom ?? true),
            ),
            dateInputField(_dateController, context, editable: true),
            textBeforeTextField("Time"),
            timeInputFields(_fromTimeController, _toTimeController, context, editable: true),
            descriptionTextField(context, _descriptionController, editable: widget.event?.isCustom ?? true),
            if (widget.event?.isCustom ?? true)
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
                      DateTime startTime = convertStringsToDateTime(_dateController.text, _fromTimeController.text);
                      DateTime endTime = convertStringsToDateTime(_dateController.text, _toTimeController.text);
                      String title = _titleController.text;
                      String? description = _descriptionController.text;

                      if (widget.event != null) {
                        widget.event!.startTime = startTime;
                        widget.event!.endTime = endTime;
                        widget.event!.title = title;
                        widget.event!.description = description;
                        widget.event!.categoryID = _selectedCategory;
                        eventProvider.updateEvent(widget.event!);

                        await sendEditEvent(eventProvider.user.getName, widget.event!, eventProvider);
                      } else {
                        await sendAddCustomEvent(
                          eventProvider.user.getName,
                          startTime,
                          endTime,
                          title,
                          description,
                          _selectedCategory,
                          eventProvider
                        );
                      }
                      if (widget.onUpdateEvent != null) {
                        widget.onUpdateEvent!(widget.event!);
                      }
                      Navigator.pop(context);
                    }
                  },
                  style: TextButton.styleFrom(backgroundColor: mainColor),
                  child: Text(
                    widget.event == null ? 'ADD EVENT' : 'EDIT EVENT',
                    style: const TextStyle(
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
