import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/signUpPageUtil.dart';
import '../httpRequests/httpRequests.dart';
import 'HomePage.dart';

class MySignUpPage extends StatefulWidget
{
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

class _MySignUpPageState extends State<MySignUpPage>
{
  final TextEditingController _emailController      = TextEditingController();
  Color mainColor = const Color(0xff083c74);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar:
        AppBar
        (
          backgroundColor: mainColor,
          toolbarHeight:   0,
          elevation:       0,
        ),
      body:
        ListView
        (
          children:
            <Widget>
            [
              buildLogoWidget(),
              buildInputTextField(_emailController, "Email"),
              Padding
              (
                padding:
                  const EdgeInsets.fromLTRB(60, 10, 60, 10),
                child:
                  SizedBox
                  (
                    width:
                      double.infinity,
                    height:
                      40,
                    child:
                      TextButton
                      (
                        onPressed:
                        ()async
                        {
                          int statcode =
                          await
                          (
                            sendSignUpStart
                            (
                                0,
                                _emailController.text
                            )
                          );
                        if(statcode == 200)
                        {
                          print("yay we sign up");
                          setState
                          (
                            ()
                            {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                            }
                          );
                        }
                      },
                      style:
                        TextButton.styleFrom(backgroundColor: mainColor),
                      child:
                        const Text
                        (
                          'SIGN UP',
                          style:
                            TextStyle
                            (
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
