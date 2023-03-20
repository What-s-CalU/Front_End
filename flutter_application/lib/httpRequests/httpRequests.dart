import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

Future<int> sendCredentials(String username, String password) async {
  return _sendJsonRequest({'request_type': 'login', 'name': username, 'password': password});
}

Future<int> sendSignUp(String firstName, String lastName, String email, String username, String password) async {
  return _sendJsonRequest({
    'request_type': 'signup',
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'username': username,
    'password': password,
  });
}

Future<int> sendAddEvent(DateTime startTime, DateTime endTime, String subject, Color color, String? description,
    int? subscriptions, String? category) async {
  return _sendJsonRequest({
    'request_type': 'add_event',
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'subject': subject,
    'color': color.value,
    'description': description,
    'subscriptions': subscriptions,
    'category': category,
  });
}

Future<int> _sendJsonRequest(Map<String, dynamic> requestBody) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );
  return response.statusCode;
}
