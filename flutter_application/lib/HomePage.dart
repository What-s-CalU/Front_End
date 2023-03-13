import 'package:flutter_application_1/AddEventPage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'Events.dart';
import 'homePageUtil.dart';

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
              dataSource: _getCalendarDataSource(),
              //appointmentBuilder: appointmentBuilder,
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
                iconButtonWithText(
                  context,
                  'Add Event',
                  () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventPage()));
                  },
                ),
                iconButtonWithText(
                  context,
                  'Manage Events',
                  () {},
                ),
                iconButtonWithText(
                  context,
                  'Remove Event',
                  () {
                    // Insert your desired action here for when the button is pressed
                  },
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
