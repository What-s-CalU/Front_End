import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> sendCredentials(String username, String password) async {
  final Map<String, String> requestBody = {
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
