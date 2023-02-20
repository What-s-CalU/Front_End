import 'package:flutter/material.dart';
import 'httpRequests.dart';
import 'HomePage.dart';

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
  bool _showPassword = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  Color mainColor = const Color(0xff083c74);
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

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
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                  hintText: "First Name", border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                  hintText: "Last Name", border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email", border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  hintText: "Username", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child: TextField(
              controller: _passwordController,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                  hintText: "Password", border: const OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                onPressed: () async {
                  int statcode = await (sendSignUp(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      _usernameController.text,
                      _passwordController.text));
                  if (statcode == 200) {
                    print("yay we sign up");
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyHomePage()));
                    });
                  }
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
        ],
      ),
    );
  }
}
