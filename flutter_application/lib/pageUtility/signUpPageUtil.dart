import 'package:flutter/material.dart';
import 'LoginPageUtil.dart';

Widget buildLogoWidget() {
  return Padding(
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
  );
}

Widget buildInputTextField(TextEditingController controller, String hintText) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}
