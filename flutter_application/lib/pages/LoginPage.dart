import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/notifcationHelper.dart';
import 'package:flutter_application_1/pages/SignUpPage.dart';
import 'package:flutter_application_1/pages/overviewPage.dart';
import 'package:provider/provider.dart';
import '../httpRequests/httpRequests.dart';
import '../pageUtility/LoginPageUtil.dart';
import '../pageUtility/eventReminders.dart';
import '../provider/eventProvider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _showPassword = false;
  final _loginformKey = GlobalKey<FormState>();
  bool _clicked = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  // Constants used by the page builder below.
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final websiteUrl = 'https://sea3212.wixsite.com/whatsatcalu';
  final websiteAboutUrl = 'https://sea3212.wixsite.com/whatsatcalu/about';
  Color mainColor = const Color(0xff083c74);

  //This function will change the state of password visibility
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState(){
    super.initState();
    requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.requestPermission();
    }
  }

  @override
  // Build script for this page
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Form(
        key: _loginformKey,
        child: ListView(
            // Main content of the page.
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // User login containers.
                  logoInContainer(),
                  buildUsernameTextFieldPadding(_usernameController),
                  buildPasswordTextFieldPadding(_passwordController, _showPassword, _togglevisibility),

                  // Forgot password button
                  buildForgotPassword(context),

                  // Script for the signin button (inline)
                  buildSignInButton(context, _usernameController, _passwordController, _clicked, () async {
                    final navigator = Navigator.of(context);
                    if (_loginformKey.currentState!.validate()) {
                      setState(() => _clicked = true);
                      final statcode = await (sendCredentials(_usernameController.text, _passwordController.text, eventProvider));
                      if (statcode == 200) {
                        print("yay we login");
                        print(statcode);
                        // Set the username in the event provider
                        // Call sendGetUserSubscribedEvents and add the events to the event provider
                        final eventsStatusCode = await sendGetUserSubscribedEvents(_usernameController.text.toUpperCase(), eventProvider);
                        if (eventsStatusCode == 200 && statcode == 200) {
                          print("Events loaded with status code: $eventsStatusCode");
                          scheduleEventReminders(eventProvider.events);
                          await sendGetUserSubscribedCategories(_usernameController.text.toUpperCase(), eventProvider);
                          eventProvider.startKeepAliveTimer();
                          // Navigate to the OverviewPage
                          navigator.push(MaterialPageRoute(builder: (context) => const OverviewPage()));
                        }
                      } else {
                        print(statcode);
                      }
                    }
                    setState(() => _clicked = false);
                  }),

                  // Script for the signup button (inline, creates page)
                  buildSignUpButton(context, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MySignUpPage()));
                  }),

                  // Misc menu bottons (website urls)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildIconButtonWithText(Icons.web, "WEBSITE", websiteUrl),
                      buildIconButtonWithText(Icons.announcement_rounded, "ABOUT", websiteAboutUrl),
                      buildIconButtonWithText(Icons.question_mark, "HELP", websiteUrl)
                    ],
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
