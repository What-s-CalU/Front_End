// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/signUpPageUtil.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
import '../httpRequests/httpRequests.dart';
import 'calendarPage.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _checksumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _passwordMirrorController = TextEditingController();
  Color mainColor = const Color(0xff083c74);

  // Control toggles for Visibility() scopes below.
  bool showEmailField = true;
  bool showChecksumField = false;
  bool showPasswordField = false;
  String buttonText = "SUBMIT";
  int screenState = 0;
  int oldScreenState = 0;

  bool hadError = false;
  String errorText = "";

  // Set this from another context to change the contents of the page.
  int isReset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          buildLogoWidget(),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: hadError,
            child: Text(
              // text field (see above).
              errorText,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),

          // Conditionally hides whatever is inside of it. Used for all text fields.
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: showEmailField,
            child: buildInputTextField(_emailController, "Email"),
          ),
          // Conditionally hides whatever is inside of it. Used for all text fields.
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: showChecksumField,
            child: buildInputTextField(_checksumController, "Code"),
          ),
          // Conditionally hides whatever is inside of it. Used for all text fields.
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: showPasswordField,
            child: buildInputTextField(_passwordController, "Password"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () async {
                  // Cache the old screen state so we can compare later. 
                  oldScreenState = screenState;
                  switch (screenState) {
                    case 0:
                      int statcode =
                          await (sendSignUpStart(0, _emailController.text));
                      if (statcode == 200) {
                        showEmailField = false;
                        showChecksumField = true;
                        buttonText = "VERIFY";
                        screenState = 1;
                        hadError = false;
                        print("Began sign up successfully.\n");
                      } else if (statcode == 401) {
                        errorText =
                            "This email is already registered; please contact \"whatsatcalu@gmail.com\" for more information.";
                        hadError = true;
                      } else {
                        errorText =
                            "Something went wrong; please try submitting again later.";
                        hadError = true;
                      }
                      break;

                    case 1:
                      int statcode = await (sendSignUpContinue(
                          0, _emailController.text, _checksumController.text));
                      if (statcode == 200) {
                        showEmailField    = false;
                        showChecksumField = false;
                        showPasswordField = true;
                        buttonText = "SIGN UP";
                        screenState = 2;
                        hadError = false;
                        print("Exchanged checksum successfully.\n");
                      } else if (statcode == 401) {
                        errorText =
                            "Incorrect code entered; doublecheck the email that was sent to your inbox at \"${_emailController.text.toLowerCase()}@pennwest.edu.\"";
                        hadError = true;
                      } else {
                        errorText =
                            "Something went wrong; please try submitting again later.";
                        hadError = true;
                      }
                      break;

                    case 2:
                      // check for same passwords goes here ...
                      int statcode = await (sendSignUpEnd(
                          0, _emailController.text, _checksumController.text, _passwordController.text));
                      if (statcode == 200) {
                        screenState = 0;
                        hadError = false;
                        print("Signed up successfully.\n");

                        // Builds the home page. This probably should boot you back to the login screen instead.
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyLoginPage()));
                        });
                      } else {
                        errorText =
                            "Something went wrong; please try submitting again later.";
                        hadError = true;
                      }
                      break;
                  }
                  // Force refresh the page if the state has changed.
                  if(oldScreenState != screenState || hadError)
                  {
                    setState(() {});
                  }
                },
                style: TextButton.styleFrom(backgroundColor: mainColor),
                child: Text(
                  // text field (see above).
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
