import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Events.dart';
import 'package:flutter_application_1/pages/eventView.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventContainer extends StatefulWidget {
  final Event event;

  const EventContainer({
    super.key,
    required this.event,
  });

  @override
  _EventContainerState createState() => _EventContainerState();
}

class _EventContainerState extends State<EventContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventViewPage(event: widget.event),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Provider.of<EventProvider>(context, listen: false).getCategoryColorById(widget.event.categoryID!),
              width: 3,
            )),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText('Title: ', widget.event.title, 14, FontWeight.bold),
                const SizedBox(height: 4),
                customText('Date: ', DateFormat.yMMMMd().format(widget.event.startTime), 14, FontWeight.bold),
                const SizedBox(height: 4),
                customText('Time: ', '${DateFormat.jm().format(widget.event.startTime)} - ${DateFormat.jm().format(widget.event.endTime)}', 14,
                    FontWeight.bold),
                const SizedBox(height: 4),
                customText('Description: ', widget.event.description ?? "No Description", 14, FontWeight.bold),
                const SizedBox(height: 4),
                customText('Category: ',  Provider.of<EventProvider>(context, listen: false).getCategoryNameById(widget.event.categoryID!), 14, FontWeight.bold),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Row customText(String text, String text2, double fontSize, FontWeight fontWeight) {
  return Row(
    children: [
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      Text(
        text2,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    ],
  );
}
