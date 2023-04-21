import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/logout.dart';
import 'package:flutter_application_1/pages/AddEventPage.dart';
import 'package:flutter_application_1/pages/categorySubscriptionPage.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/appointmentBuilder.dart';
import '../model/eventDataSource.dart';
import '../pageUtility/navigationBar.dart';
import '../provider/eventProvider.dart';


class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: true);
    Color mainColor = const Color(0xff083c74);
    final CalendarController calendarController = CalendarController();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: const Text('Home'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showLogoutConfirmation(context);
            }
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategorySubscriptionPage()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventPage()));
              },
            ),
          ],
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
                      padding: const EdgeInsets.all(5),
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
                            height: 350,
                            child: SfCalendar(
                              view: CalendarView.schedule,
                              headerHeight: 0,
                              dataSource: EventDataSource(eventProvider.getEventsByDaysAway(7), eventProvider),
                              controller: calendarController,
                              appointmentBuilder: (context, details) => appointmentBuilder(context, details, calendarController),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: customBottomNavigationBar(context),
      ),
    );
  }
}
