import 'package:flutter/material.dart';
import 'package:flutter_application_1/httpRequests/httpRequests.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';
///shows a dialog box for the user to choose to logout.
///if yes pops twice to home screen and deletes data in event provider.
Future<void> showLogoutConfirmation(BuildContext context) async {
  final eventProvider = Provider.of<EventProvider>(context, listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              // Perform the logout action here
              sendLogout(eventProvider.user.getName, eventProvider.user.getChecsum, eventProvider);
              eventProvider.logout();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}