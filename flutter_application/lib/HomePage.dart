import 'package:flutter_application_1/AddEventPage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'Events.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  final CalendarController _controller = CalendarController();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color mainColor = const Color(0xff083c74);
  Color BackgroundColor = const Color(0xff3A3B3C);

  @override
  Widget build(BuildContext context) {
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
              allowedViews: [
                CalendarView.day,
                CalendarView.week,
                CalendarView.month,
              ],
              viewHeaderStyle: ViewHeaderStyle(),
              initialDisplayDate: DateTime.now(),
              dataSource: EventDataSource(events),
              appointmentBuilder: appointmentBuilder,
              monthViewSettings: MonthViewSettings(
                showAgenda: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventPage()));
                        });
                      },
                      icon: Icon(Icons.add_circle_rounded, color: mainColor),
                    ),
                    Text(
                      'Add Event',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.manage_search_outlined, color: mainColor),
                    ),
                    Text(
                      'Manage Events',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.remove_circle_rounded, color: mainColor),
                    ),
                    Text(
                      'Remove Event',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Widget appointmentBuilder(BuildContext context,
//     CalendarAppointmentDetails calendarAppointmentDetails) {
//   final Appointment appointment = calendarAppointmentDetails.appointments.first;
//   return Column(
//     children: [
//       Container(
//           width: calendarAppointmentDetails.bounds.width,
//           height: calendarAppointmentDetails.bounds.height / 2,
//           color: appointment.color,
//           child: Center(
//             child: Icon(
//               Icons.group,
//               color: Colors.black,
//             ),
//           )),
//       Container(
//         width: calendarAppointmentDetails.bounds.width,
//         height: calendarAppointmentDetails.bounds.height / 2,
//         color: appointment.color,
//         child: Text(
//           appointment.subject +
//               DateFormat(' (hh:mm a').format(appointment.startTime) +
//               '-' +
//               DateFormat('hh:mm a)').format(appointment.endTime),
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 10),
//         ),
//       )
//     ],
//   );
// }

// class Appointment {
//   String subject;
//   DateTime startTime;
//   DateTime endTime;
//   String description;
//   Color color;

//   Appointment(
//       {required this.subject,
//       required this.color,
//       required this.startTime,
//       required this.endTime,
//       required this.description});
// }
