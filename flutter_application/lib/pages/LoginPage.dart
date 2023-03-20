import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/SignUpPage.dart';
import 'HomePage.dart';
import '../httpRequests/httpRequests.dart';
import '../pageUtility/LoginPageUtil.dart';

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

  //This function will change the state of password visibility
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logoInContainer(),
            buildUsernameTextFieldPadding(_usernameController),
            buildPasswordTextFieldPadding(_passwordController, _showPassword, _togglevisibility),
            buildForgotPassword(context),
            buildSignInButton(context, _usernameController, _passwordController, () async {
              int statcode = 200;
              await (sendCredentials(_usernameController.text, _passwordController.text));
              if (statcode == 200) {
                print("yay we login");
                print(statcode);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
              } else {
                print(statcode);
              }
            }),
            buildSignUpButton(context, () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MySignUpPage()));
            }),
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
    );
  }
}
