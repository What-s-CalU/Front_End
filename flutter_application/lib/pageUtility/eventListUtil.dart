import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Events.dart';
import 'package:flutter_application_1/pages/eventView.dart';
import 'package:intl/intl.dart';

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
              color: widget.event.color,
              width: 3,
            )),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText('Title:', 14, FontWeight.bold),
                customText(widget.event.title, 14, FontWeight.normal),
                const SizedBox(height: 4),
                customText('Date:', 14, FontWeight.bold),
                customText(DateFormat.yMMMMd().format(widget.event.startTime),
                    14, FontWeight.normal),
                const SizedBox(height: 4),
                customText('Time:', 14, FontWeight.bold),
                customText(
                    '${DateFormat.jm().format(widget.event.startTime)} - ${DateFormat.jm().format(widget.event.endTime)}',
                    14,
                    FontWeight.normal),
                const SizedBox(height: 4),
                customText('Description:', 14, FontWeight.bold),
                customText(widget.event.description!, 12, FontWeight.normal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Text customText(String text, double fontSize, FontWeight fontWeight) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
