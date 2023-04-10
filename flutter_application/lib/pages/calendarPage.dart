import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/pages/AddEventPage.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import '../model/eventDataSource.dart';
import '../model/appointmentBuilder.dart';
import '../pageUtility/navigationBar.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color mainColor = const Color(0xff083c74);
  final CalendarController _calendarController = CalendarController();

  String appBarTitle = DateFormat('MMMM, y').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: AppBarTitle(title: appBarTitle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventPage()));
            },
          ),
          PopupMenuButton<CalendarView>(
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<CalendarView>(
                value: CalendarView.day,
                child: Text('Day'),
              ),
              const PopupMenuItem<CalendarView>(
                value: CalendarView.week,
                child: Text('Week'),
              ),
              const PopupMenuItem<CalendarView>(
                value: CalendarView.month,
                child: Text('Month'),
              ),
            ],
            onSelected: (CalendarView value) {
              setState(() {
                _calendarController.view = value;
              });
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
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
              appointmentBuilder: (context, details) => appointmentBuilder(context, details, _calendarController),
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),
              timeSlotViewSettings: const TimeSlotViewSettings(timeIntervalHeight: -1),
              headerHeight: 0,
              onViewChanged: (ViewChangedDetails details) {
                final displayDate = details.visibleDates.first;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    if (_calendarController.view == CalendarView.day) {
                      appBarTitle = DateFormat('MMMM d, y').format(displayDate);
                    } else if (_calendarController.view == CalendarView.week) {
                      appBarTitle = DateFormat('MMMM, y').format(displayDate);
                    } else if (_calendarController.view == CalendarView.month) {
                      DateTime nextMonthDisplayDate = DateTime(displayDate.year, displayDate.month + 1, 1);
                      appBarTitle = DateFormat('MMMM, y').format(nextMonthDisplayDate);
                    }
                  });
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: customBottomNavigationBar(context),
    );
  }
}

class AppBarTitle extends StatefulWidget {
  final String title;

  const AppBarTitle({required this.title, Key? key}) : super(key: key);

  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }
}
