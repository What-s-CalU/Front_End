import 'dart:convert';
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

Future<int> sendAddEvent(String name, String description, String start, String end) async {
  final Map<String, String> requestBody = {
    'name': name,
    'description': description,
    'start': start,
    'end': end,
  };
  final http.Response response = await http.post(
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );

  return response.statusCode;
}
