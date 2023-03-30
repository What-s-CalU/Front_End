import 'package:flutter_application_1/pages/AddEventPage.dart';
import 'package:flutter_application_1/pages/eventList.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import '../model/eventDataSource.dart';
import 'package:flutter_application_1/pageUtility/calendarPageUtil.dart';
import '../model/appointmentBuilder.dart';
import '../pageUtility/navigationBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color mainColor = const Color(0xff083c74);
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SfCalendar(
              view: CalendarView.day,
              controller: _calendarController,
              allowedViews: const [
                CalendarView.day,
                CalendarView.week,
                CalendarView.month,
              ],
              initialDisplayDate: DateTime.now(),
              dataSource: EventDataSource(events),
              appointmentBuilder: (context, details) =>
                  appointmentBuilder(context, details, _calendarController),
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: customBottomNavigationBar(context),
    );
  }
}
