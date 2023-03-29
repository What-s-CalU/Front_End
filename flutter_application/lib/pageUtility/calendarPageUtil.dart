import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/LoginPageUtil.dart';

Column iconButtonWithText(BuildContext context, String buttonText, VoidCallback onPressed) {
  return Column(
    children: [
      IconButton(
        iconSize: 40,
        onPressed: onPressed,
        icon: Icon(Icons.add_circle_rounded, color: mainColor),
      ),
      Text(
        buttonText,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ],
  );
}
