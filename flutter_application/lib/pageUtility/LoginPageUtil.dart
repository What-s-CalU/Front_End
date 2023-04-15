import 'package:flutter_application_1/pages/forgotPassword.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color mainColor = const Color(0xff083c74);

///  Logo 200x200 in a container with main color
///
///  Parameters : none
///
///  Return: Padding Object
///
///  Author: Thomas Terhune
Padding logoInContainer() {
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


///  Builds a username text field with validation to ensure the field is not empty.
///
///  Parameters: 
///    controller: A TextEditingController object for managing the input and decoration of the TextFormField widget.
///
///  Returns: 
///    A Padding widget containing the TextFormField with validation.
///
///  Author: Thomas Terhune
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


///  Builds a password text field with validation to ensure the field is not empty.
///
///  Parameters:
///    controller: a TextEditingController object for managing the input and decoration of the TextField widget.
///    showPassword: a boolean value indicating whether or not the password should be obscured.
///    toggleVisibility: a VoidCallback function for toggling the visibility of the password.
///
///  Return: A Padding widget containing the TextFormField with validation.
///
///  Author: Thomas Terhune

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


/// Icon Button with text underneath which launches a passed url
///
///  Parameters:
///    icon: an IconData object representing the icon to be displayed.
///    text: a String object representing the text to be displayed.
///    url: a String object representing the URL to be launched when the IconButton is pressed.
///
///  Return: Column object
///
///  Author: Thomas Terhune
///
Column buildIconButtonWithText(IconData icon, String text, String url) {
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



///  Sign Up Button with onPressed functionality passed in
///
///  Parameters:
///    context: a BuildContext object.
///    onPressed: a VoidCallback function to be called when the TextButton is pressed.
///
///  Return: Padding object
///
///  Author: Thomas Terhune
Padding buildSignUpButton(BuildContext context, VoidCallback onPressed) {
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



  
///  Sign In Button With onPressed action pessed in 
///
///  Parameters:
///    context: a BuildContext object.
///    usernameController: a TextEditingController object for managing the input of the username.
///    passwordController: a TextEditingController object for managing the input of the password.
///    onPressed: a VoidCallback function to be called when the TextButton is pressed.
///
///  Return: Padding object
///
///  Author: Thomas Terhune
Padding buildSignInButton(
  BuildContext context,
  TextEditingController usernameController,
  TextEditingController passwordController,
  bool clicked,
  VoidCallback onPressed,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
    child: SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        onPressed: clicked 
                ? null
                : onPressed,
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



///  Forgot password text with inkwell
///  when clicked goes to reset password page
/// 
///  Parameters:
///    context: a BuildContext object.
///
///  Return: Padding object
///
///  Author: Thomas Terhune
Padding buildForgotPassword(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
    child: Align(
      alignment: Alignment.topRight,
      child: InkWell(
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



///  launch a specified url
///
///  Parameters:
///    url: a Uri object representing the URL to be launched.
///
///  Return: Future object representing the result of launching the URL.
///
///  Author: Thomas Terhune
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
