import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  Color mainColor = const Color(0xff083c74);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Title", border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Date", border: const OutlineInputBorder()),
            ),
          ),
          Row(
            children: <Widget>[
              //from date
              //to date
              //am/pm
            ],
          )
        ],
      ),
    );
  }
}
