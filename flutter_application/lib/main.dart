// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Color mainColor = Color(0xff083c74);
    return Scaffold(
      //Remove elevation and of appbar and remove the extra title portion
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(children: <Widget>[
        Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //LOGO
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Container(
                color: mainColor,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Image(
                    height: 200,
                    width: 200,
                    image: AssetImage('assets/Logo2.png'),
                  ),
                ),
              ),
            ),
            //USERNAME INPUT
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Username",
                    border: OutlineInputBorder()),
              ),
            ),
            //PASSWORD INPUT
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
              child: TextField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglevisibility();
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder()),
              ),
            ),
            //FORGOT PASSWORD
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
              child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      print('Forgot Password...');
                    },
                    child: Text(
                      "Forgot Password?",
                    ),
                  )),
            ),
            //LOGIN BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    print('Loggin in');
                  },
                  style: TextButton.styleFrom(backgroundColor: mainColor),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //SIGN UP BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    print('Loggin in');
                  },
                  style: TextButton.styleFrom(backgroundColor: mainColor),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //ROW FOR ICONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //WEBSITE ICON
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.web, color: mainColor),
                    ),
                    Text(
                      'Website',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                //ABOUT ICON
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.announcement_rounded, color: mainColor),
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                //HELP ICON
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.question_mark, color: mainColor),
                    ),
                    Text(
                      'Help',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
