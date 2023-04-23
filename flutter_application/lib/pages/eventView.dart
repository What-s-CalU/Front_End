import 'package:flutter/material.dart';
import 'package:flutter_application_1/httpRequests/httpRequests.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/model/Events.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';

import 'AddEventPage.dart';

class EventViewPage extends StatefulWidget {
  final Event event;
  const EventViewPage({Key? key, required this.event}) : super(key: key);

  @override
  _EventViewPageState createState() => _EventViewPageState();
}

class _EventViewPageState extends State<EventViewPage> {
  Color mainColor = const Color(0xff083c74);

  void _updateEvent(Event updatedEvent) {
    setState(() {
      widget.event.startTime = updatedEvent.startTime;
      widget.event.endTime = updatedEvent.endTime;
      widget.event.title = updatedEvent.title;
      widget.event.description = updatedEvent.description;
      widget.event.categoryID = updatedEvent.categoryID;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Event Details'),
        centerTitle: true,
        actions: [
          if (widget.event.isCustom)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEventPage(
                      event: widget.event,
                      onUpdateEvent: _updateEvent,
                    ),
                  ),
                );
              },
            ),
          if (widget.event.isCustom)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                sendDeleteCustomEvent(widget.event.id, eventProvider);
                eventProvider.removeEvent(widget.event);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          DateFormat.yMMMMd().format(widget.event.startTime),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.timer),
                        title: Text(
                          '${DateFormat.jm().format(widget.event.startTime)} - ${DateFormat.jm().format(widget.event.endTime)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.description),
                        title: const Text(
                          'Description',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(widget.event.description ?? 'No description provided'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.category),
                        title: const Text(
                          'Category',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(eventProvider.getCategoryNameById(widget.event.categoryID!)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
