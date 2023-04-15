import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '../model/EventCategory.dart';
import '../model/Events.dart';
import '../provider/eventProvider.dart';

Future<int> sendCredentials(String username, String password, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({'request_type': 'signin', 'username': username, 'password': password});

  final jsonresponse = json.decode(response.body);
  eventProvider.user.id = (jsonresponse['id']);
  eventProvider.user.name = username;
  eventProvider.user.checksum = (jsonresponse['checksum']);
  return response.statusCode;
}

Future<int> sendSignUp(String firstName, String lastName, String email, String username, String password) async {
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

///The first of three handshake events used to signup for a new account.
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

///Checks for a given checksum stored locally on the server in a dummy database.
Future<int> sendSignUpContinue(int isReset, String username, String checksum) async {
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

  final response = await _sendJsonRequest({'request_type': requestType, 'checksum': checksum, 'username': username, 'password': password});
  return response.statusCode;
}

///adds custom event to the databse, adds event to eventProvider Event list with id recieved from the server
Future<void> sendAddCustomEvent(String username, DateTime startTime, DateTime endTime, String title, String? description, int? categoryID, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({
    'request_type': 'add_custom_event',
    'username': username,
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'title': title,
    'description': description,
    'categoryID': categoryID,
    'isCustom': true,
    'checksum' : eventProvider.user.checksum,
  });
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    int eventId = jsonResponse['ID'];

    Event newEvent = Event.fromDict({
      'id': eventId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'title': title,
      'description': description,
      'categoryID': categoryID,
      'isCustom': 1,
      'flag': 0,
      'checksum' : eventProvider.user.checksum,
    });

    eventProvider.addEvent(newEvent);
  }
}

///delete custom event from the database
Future<void> sendDeleteCustomEvent(
    int eventID, EventProvider eventProvider) async {
    await _sendJsonRequest({
    'request_type': 'delete_event',
    'event_id': eventID,
    'checksum' : eventProvider.user.checksum,
  });
}

///gets user subscribed events from the server and adds them to the event provider
Future<int> sendGetUserSubscribedEvents(String username, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({
    'request_type': 'get_user_subscribed_events',
    'username': username,
    'checksum' : eventProvider.user.checksum,
  });
  print(eventProvider.user.checksum);
  print('Received JSON data: ${response.body}');

  if (response.statusCode == 200) {
    final List<Event> events = parseJsonToEvents(response.body);
    eventProvider.addEvents(events);
  }
  return response.statusCode;
}

///gets user subscribed categories from the server add adds then to this list in the eventprovider
Future<void> sendGetUserSubscribedCategories(String username, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({
    'request_type': 'get_user_subscribed_categories',
    'username': username,
    'checksum' : eventProvider.user.checksum,
  });

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    List<EventCategory> categories = jsonResponse.map((categoryJson) => EventCategory.fromJson(categoryJson)).toList();
    eventProvider.addCategories(categories);
  }
}

///updates the status of a user subscription to a category in the server
Future<void> sendUpdateCategorySubscription(String username, int categoryID, bool isSubscribed, EventProvider eventProvider) async {
  await _sendJsonRequest({
    'request_type': 'update_calu_category_subscription',
    'username': username,
    'category_id': categoryID,
    'is_subscribed': isSubscribed ? 1 : 0,
    'checksum' : eventProvider.user.checksum,
  });
}

///get all calu category events from the server and add them to the even provider
Future<void> getCaluCategoryEvents(int categoryID, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({
    'request_type': 'get_calu_category_events',
    'category_id': categoryID,
    'checksum' : eventProvider.user.checksum,
  });
  if (response.statusCode == 200) {
    final List<Event> events = parseJsonToEvents(response.body);
    eventProvider.addEvents(events);
  }
}

///adds a new user created category to the database, returns id and adds it to the event provider
Future<int> sendAddCategory(String username, String categoryName, Color categoryColor, EventProvider eventProvider) async {
  final response = await _sendJsonRequest({
    'request_type': 'add_category',
    'username' : username,
    'category_name': categoryName,
    'color' : categoryColor.value,
    'checksum' : eventProvider.user.checksum,
  });
  final jsonResponse = json.decode(response.body);
  int categoryId = jsonResponse['category_id'];
  eventProvider.addCategory(EventCategory(
      id: categoryId,
      name: categoryName,
      color: categoryColor,
      userID: eventProvider.user.getId, 
    )
  );
  return categoryId;
}

Future<void> sendLogout(String username, String checksum, EventProvider eventProvider) async {
  await _sendJsonRequest({
    'request_type': 'signout',
    'username' : username,
    'checksum' : eventProvider.user.checksum,
  });
}

///base request template
Future<http.Response> _sendJsonRequest(Map<String, dynamic> requestBody) async {
  return await http.post(
    Uri.parse("http://10.0.2.2:80"),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(requestBody),
  );
}
///parse json to event object
List<Event> parseJsonToEvents(String jsonString) {
  final List<dynamic> parsedJson = jsonDecode(jsonString);
  return parsedJson.map((eventDict) => Event.fromDict(eventDict as Map<String, dynamic>)).toList();
}

