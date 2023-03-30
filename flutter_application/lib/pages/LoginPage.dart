import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/SignUpPage.dart';
import 'calendarPage.dart';
import '../httpRequests/httpRequests.dart';
import '../pageUtility/LoginPageUtil.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _showPassword = false;

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
  // Build script for this page
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
          // Main content of the page.
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // User login containers.
                logoInContainer(),
                buildUsernameTextFieldPadding(_usernameController),
                buildPasswordTextFieldPadding(
                    _passwordController, _showPassword, _togglevisibility),

                // Forgot password button
                buildForgotPassword(context),

                // Script for the signin button (inline)
                buildSignInButton(
                    context, _usernameController, _passwordController,
                    () async {
                  int statcode = 200; //await (sendCredentials(
                  //_usernameController.text, _passwordController.text));
                  if (statcode == 200) {
                    print("yay we login");
                    print(statcode);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  } else {
                    print(statcode);
                  }
                }),

                // Script for the signup button (inline, creates page)
                buildSignUpButton(context, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MySignUpPage()));
                }),

                // Misc menu bottons (website urls)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIconButtonWithText(Icons.web, "WEBSITE", websiteUrl),
                    buildIconButtonWithText(
                        Icons.announcement_rounded, "ABOUT", websiteAboutUrl),
                    buildIconButtonWithText(
                        Icons.question_mark, "HELP", websiteUrl)
                  ],
                ),
              ],
            ),
          ]),
    );
  }
}
