import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../model/Events.dart';
import '../provider/eventProvider.dart';

Future<int> sendCredentials(String username, String password) async {
  final response = await _sendJsonRequest(
      {'request_type': 'signin', 'username': username, 'password': password});
  return response.statusCode;
}

Future<int> sendSignUp(String firstName, String lastName, String email,
    String username, String password) async {
  final response = await _sendJsonRequest({
    'request_type': 'signup',
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'username': username,
    'password': password,
  });
  return response.statusCode;
}

// The first of three handshake events used to signup for a new account.
Future<int> sendSignUpStart(int isReset, String username) async {
  // By default we use the reset type
  String requestType = "reset_start";
  if (isReset == 0) {
    requestType = "signup_start";
  }

  // Returns the given requesttype.
  final response = await _sendJsonRequest({
    'request_type': requestType,
    'username': username,
  });
  return response.statusCode;
}

// Checks for a given checksum stored locally on the server in a dummy database.
Future<int> sendSignUpContinue(
    int isReset, String username, String checksum) async {
  // By default we use the reset type
  String requestType = "reset_continue";
  if (isReset == 0) {
    requestType = "signup_continue";
  }

  final response = await _sendJsonRequest({
    'request_type': requestType,
    'username': username,
    'checksum': checksum,
  });
  return response.statusCode;
}

Future<int> sendSignUpEnd(int isReset, String username, String checksum, String password) async {
  // By default we use the reset type
  String requestType = "reset_end";
  if (isReset == 0) {
    requestType = "signup_end";
  }

  final response = await _sendJsonRequest({
    'request_type': requestType,
    'checksum': checksum,
    'username': username,
    'password': password
  });
  return response.statusCode;
}

Future<int> sendAddCustomEvent(
    String username,
    DateTime startTime,
    DateTime endTime,
    String subject,
    Color color,
    String? description,
    String? category) async {
  final response = await _sendJsonRequest({
    'request_type': 'add_custom_event',
    'username': username,
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'title': subject,
    'color': color.value,
    'description': description,
    'category': category,
    'isCustom': true,
  });
  return response.statusCode;
}

Future<int> sendGetUserSubscribedEvents(String username, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({
    'request_type': 'get_user_subscribed_events',
    'username': username,
  });
  print('Received JSON data: ${response.body}');  

  if (response.statusCode == 200) {
    final List<Event> events = parseJsonToEvents(response.body);
    eventProvider.addEvents(events);
    eventProvider.setColorsForCategories(events);
  }
  return response.statusCode;
}

Future<http.Response> _sendJsonRequest(Map<String, dynamic> requestBody) async {
  return await http.post(
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );
}

List<Event> parseJsonToEvents(String eventsJsonString) {
  List<dynamic> jsonResponse = json.decode(eventsJsonString);
  return jsonResponse.map((eventJson) => eventFromJson(eventJson)).toList();
}

Event eventFromJson(Map<String, dynamic> json) {
  return Event(
    startTime: DateTime.parse(json['start_time']),
    endTime: DateTime.parse(json['end_time']),
    title: json['title'],
    color: Color(json['color']),
    description: json['description'],
    category: json['category'],
    isCustom: json['isCustom'].isOdd,
  );
}