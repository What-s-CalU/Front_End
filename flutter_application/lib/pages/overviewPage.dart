import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/AddEventPage.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/eventDataSource.dart';
import '../pageUtility/navigationBar.dart';
import '../provider/eventProvider.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    Color mainColor = const Color(0xff083c74);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "What's @ CalU",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    shadows: const [
                      Shadow(
                        blurRadius: 6.0,
                        color: Colors.black26,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: mainColor,
                    width: 2.0,
                  ),
                ),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upcoming',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 200,
                          child: SfCalendar(
                            view: CalendarView.schedule,
                            headerHeight: 0,
                            dataSource: EventDataSource(events),
                            scheduleViewSettings: const ScheduleViewSettings(
                                hideEmptyScheduleWeek: true,
                                monthHeaderSettings: MonthHeaderSettings(
                                  height: 0,
                                ),
                                weekHeaderSettings: WeekHeaderSettings(
                                  height: 0,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildButton(context, 'ADD EVENT', mainColor, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventPage()));
              }),
              const SizedBox(height: 10),
              buildButton(context, 'MANAGE SUBSCRIPTIONS', mainColor, () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => OverviewPage()));
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: customBottomNavigationBar(context),
    );
  }

  SizedBox buildButton(BuildContext context, String text, Color mainColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: mainColor),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
