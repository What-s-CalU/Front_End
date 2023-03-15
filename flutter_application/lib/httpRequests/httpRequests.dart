import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

Future<int> sendCredentials(String username, String password) async {
  final Map<String, String> requestBody = {
    'name': username,
    'password': password,
  };
  final http.Response response = await http.post(
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );

  return response.statusCode;
}

Future<int> sendSignUp(String firstName, String lastName, String email, String username, String password) async {
  final Map<String, String> requestBody = {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'username': username,
    'password': password,
  };
  final http.Response response = await http.post(
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );

  return response.statusCode;
}

Future<int> sendAddEvent(
  DateTime startTime,
  DateTime endTime,
  String subject,
  Color color,
  String? description,
  int? subscriptions,
  String? category,
) async {
  final url = Uri.parse("http://10.0.2.2:80");
  final headers = <String, String>{
    'Content-Type': 'application/json',
  };
  final body = jsonEncode(<String, dynamic>{
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'subject': subject,
    'color': color.value,
    'description': description,
    'subscriptions': subscriptions,
    'category': category,
  });
  final response = await http.post(url, headers: headers, body: body);
  return response.statusCode;
}
