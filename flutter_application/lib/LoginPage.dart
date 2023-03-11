import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignUpPage.dart';
import 'package:http/src/response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'HomePage.dart';
import 'httpRequests.dart';
import 'package:http_status_code/http_status_code.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'SignUpPage.dart';
import 'package:intl/intl.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _showPassword = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final websiteUrl = 'https://sea3212.wixsite.com/whatsatcalu';
  final websiteAboutUrl = 'https://sea3212.wixsite.com/whatsatcalu/about';
  Color mainColor = const Color(0xff083c74);
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
    // than having to individually change instances of widgets
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    color: mainColor,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Image(
                        height: 200,
                        width: 200,
                        image: AssetImage('assets/Logo2.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: "Username",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility();
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        hintText: "Password",
                        border: const OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          print('Forgot Password...');
                        },
                        child: const Text(
                          "Forgot Password?",
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        int statcode = await (sendCredentials(
                            _usernameController.text,
                            _passwordController.text));
                        if (statcode == 200) {
                          print("yay we login");
                          print(statcode);
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                          });
                        } else {
                          print(statcode);
                        }
                      },
                      style: TextButton.styleFrom(backgroundColor: mainColor),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MySignUpPage()));
                        });
                      },
                      style: TextButton.styleFrom(backgroundColor: mainColor),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          iconSize: 40,
                          onPressed: () {
                            _launchUrl(Uri.parse(websiteUrl));
                          },
                          icon: Icon(Icons.web, color: mainColor),
                        ),
                        const Text(
                          'Website',
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
                          onPressed: () {
                            _launchUrl(Uri.parse(websiteAboutUrl));
                          },
                          icon: Icon(Icons.announcement_rounded,
                              color: mainColor),
                        ),
                        const Text(
                          'About',
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
                          icon: Icon(Icons.question_mark, color: mainColor),
                        ),
                        const Text(
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

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
