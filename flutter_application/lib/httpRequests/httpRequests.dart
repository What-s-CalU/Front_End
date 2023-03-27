import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

Future<int> sendCredentials(String username, String password) async
{
  return _sendJsonRequest
  (
    {
      'request_type': 'signin',
      'username':     username,
      'password':     password
    }
  );
}

Future<int> sendSignUp(String firstName, String lastName, String email, String username, String password) async
{
  return _sendJsonRequest
  (
    {
      'request_type': 'signup',
      'firstName':    firstName,
      'lastName':     lastName,
      'email':        email,
      'username':     username,
      'password':     password,
    }
  );
}


// The first of three handshake events used to signup for a new account. 
Future<int> sendSignUpStart(int isReset, String username) async
{

  // By default we use the reset type
  String requestType = "reset_start";
  if(isReset == 0)
  {
    requestType = "signup_start";
  }

  // Returns the given requesttype. 
  return _sendJsonRequest
    (
      {
        'request_type': requestType,
        'username':     username,
      }
    );
}


// Checks for a given checksum stored locally on the server in a dummy database. 
Future<int> sendSignUpContinue(int isReset, String username, String checksum) async
{
  // By default we use the reset type
  String requestType = "reset_continue";
  if(isReset == 0)
  {
    requestType = "signup_continue";
  }

  return _sendJsonRequest
  (
    {
      'request_type': requestType,
      'username':     username,
      'checksum':     checksum,
    }
  );
}

Future<int> sendSignUpEnd(int isReset, String username, String password) async
{
  // By default we use the reset type
  String requestType = "reset_end";
  if(isReset == 0)
  {
    requestType = "signup_end";
  }

  return _sendJsonRequest
  (
    {
      'request_type': requestType,
      'username':     username,
      'password':     password
    }
  );
}

Future<int> sendAddEvent
(
  DateTime startTime,
  DateTime endTime,
  String   subject,
  Color    color,
  String?  description,
  int?     subscriptions,
  String?  category
) async
{
  return _sendJsonRequest
  (
    {
      'request_type':   'add_event',
      'start_time':     startTime.toIso8601String(),
      'end_time':       endTime.toIso8601String(),
      'subject':        subject,
      'color':          color.value,
      'description':    description,
      'subscriptions':  subscriptions,
      'category':       category,
    }
  );
}

Future<int> _sendJsonRequest(Map<String, dynamic> requestBody) async
{
  final response = await http.post
  (
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );
  return response.statusCode;
}