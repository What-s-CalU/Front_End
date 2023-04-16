import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/notifcationHelper.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'pages/LoginPage.dart';
import 'package:provider/provider.dart';

void main()  async
{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initNotifications();
  runApp
  (
    const MyApp(),
  );
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider
    (
      create: (context) => EventProvider(),
      child:
      const MaterialApp
      ( 
          home: MyLoginPage(),
      ),
    );
  }
}
