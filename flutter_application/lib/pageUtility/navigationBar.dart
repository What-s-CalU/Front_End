import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/calendarPage.dart';
import 'package:flutter_application_1/pages/eventList.dart';

Container customBottomNavigationBar(BuildContext context) {
  Color mainColor = const Color(0xff083c74);

  return Container(
    color: mainColor,
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildIconButton(
            context, Icons.home, 'Home', const MyHomePage(), mainColor),
        const VerticalDivider(
            color: Colors.white, thickness: 1.0, indent: 10, endIndent: 10),
        buildIconButton(context, Icons.calendar_today, 'Calendar',
            const MyHomePage(), mainColor),
        const VerticalDivider(
            color: Colors.white, thickness: 1.0, indent: 10, endIndent: 10),
        buildIconButton(context, Icons.list, 'List', EventList(), mainColor),
      ],
    ),
  );
}

Widget buildIconButton(BuildContext context, IconData icon, String label,
    Widget destinationPage, Color mainColor) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => destinationPage));
    },
    child: Column(
      children: [
        SizedBox(
          width: 60,
          height: 40,
          child: Icon(icon, color: Colors.white),
        ),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
