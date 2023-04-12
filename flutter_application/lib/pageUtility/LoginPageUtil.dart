import 'package:flutter_application_1/pages/forgotPassword.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color mainColor = const Color(0xff083c74);

/*
  A widget function that returns a container with an image logo inside it.
  The container has a fixed mainColor background and takes the full width of its parent.
  The logo image has a fixed height and width of 200 pixels and is centered inside the container.

  parameters : none

  Return: Widget Object

  Author: Thomas Terhune
*/
Widget logoInContainer() {
  const EdgeInsets padding = EdgeInsets.fromLTRB(0, 0, 0, 20);
  const EdgeInsets innerPadding = EdgeInsets.fromLTRB(0, 20, 0, 20);

  return Padding(
    padding: padding,
    child: Container(
      color: mainColor,
      width: double.infinity,
      child: const Padding(
        padding: innerPadding,
        child: Image(
          height: 200,
          width: 200,
          image: AssetImage('assets/Logo2.png'),
        ),
      ),
    ),
  );
}

/*
  Builds a username text field with validation to ensure the field is not empty.

  Parameters: 
    controller: A TextEditingController object for managing the input and decoration of the TextFormField widget.

  Returns: 
    A Padding widget containing the TextFormField with validation.

  Author: Thomas Terhune
*/
Padding buildUsernameTextFieldPadding(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
    child: TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        hintText: "Username",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        return null;
      },
    ),
  );
}

/*
  Builds a password text field with validation to ensure the field is not empty.

  Parameters:
    controller: a TextEditingController object for managing the input and decoration of the TextField widget.
    showPassword: a boolean value indicating whether or not the password should be obscured.
    toggleVisibility: a VoidCallback function for toggling the visibility of the password.

  Return: A Padding widget containing the TextFormField with validation.

  Author: Thomas Terhune
*/
Padding buildPasswordTextFieldPadding(
    TextEditingController controller, bool showPassword, VoidCallback toggleVisibility) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: TextFormField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open),
        suffixIcon: GestureDetector(
          onTap: toggleVisibility,
          child: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        hintText: "Password",
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    ),
  );
}

/*
  A widget function that returns a Column widget containing an IconButton widget and a Text widget.
  The IconButton widget contains an icon and its color is set to the mainColor constant.
  When pressed, it launches the URL passed as a String argument using the _launchUrl function.
  The Text widget displays the text passed as a String argument and has a black color.

  Parameters:
    icon: an IconData object representing the icon to be displayed.
    text: a String object representing the text to be displayed.
    url: a String object representing the URL to be launched when the IconButton is pressed.

  Return: Widget object

  Author: Thomas Terhune
*/
Widget buildIconButtonWithText(IconData icon, String text, String url) {
  return Column(
    children: [
      IconButton(
        iconSize: 40,
        onPressed: () {
          _launchUrl(Uri.parse(url));
        },
        icon: Icon(icon, color: mainColor),
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ],
  );
}

/*
  A widget function that returns a Padding widget containing a TextButton widget with the text "SIGN UP".
  The TextButton widget has a background color of mainColor constant and a fixed width and height.
  When pressed, it calls the function passed as a VoidCallback argument.

  Parameters:
    context: a BuildContext object.
    onPressed: a VoidCallback function to be called when the TextButton is pressed.

  Return: Widget object

  Author: Thomas Terhune
*/
Widget buildSignUpButton(BuildContext context, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
    child: SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: mainColor),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

/*
  A widget function that returns a Padding widget containing a TextButton widget with the text "SIGN IN".
  The TextButton widget has a background color of mainColor constant and a fixed width and height.
  When pressed, it calls the function passed as a VoidCallback argument.
  The TextButton widget is bound to two TextEditingController objects for managing the input of the username and password.
  These two TextEditingController objects are passed as arguments.

  Parameters:
    context: a BuildContext object.
    usernameController: a TextEditingController object for managing the input of the username.
    passwordController: a TextEditingController object for managing the input of the password.
    onPressed: a VoidCallback function to be called when the TextButton is pressed.

  Return: Widget object

  Author: Thomas Terhune
*/
Widget buildSignInButton(
  BuildContext context,
  TextEditingController usernameController,
  TextEditingController passwordController,
  VoidCallback onPressed,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
    child: SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: mainColor),
        child: const Text(
          'SIGN IN',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

/*
  A widget function that returns a Padding widget containing a GestureDetector widget with the text "Forgot Password?".
  The GestureDetector widget calls the print() function when tapped.
  The Padding widget has a top-right alignment and padding of 0 on the left and bottom and 20 on the right.

  Parameters:
    context: a BuildContext object.

  Return: Widget object

  Author: Thomas Terhune
*/
Widget buildForgotPassword(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
    child: Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          print('Forgot Password...');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyResetPage()));
        },
        child: const Text(
          "Forgot Password?",
        ),
      ),
    ),
  );
}

/*
  A Future function that launches a URL.
  The function takes a Uri object as input and returns a Future<void>.
  It calls the launchUrl() function to launch the URL.
  If the URL launch fails, the function throws an Exception.

  Parameters:
    url: a Uri object representing the URL to be launched.

  Return: Future object representing the result of launching the URL.

  Author: Thomas Terhune
*/
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
