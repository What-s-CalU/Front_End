import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';
import '../httpRequests/httpRequests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/EventCategory.dart';

class CategorySubscriptionPage extends StatefulWidget {
  const CategorySubscriptionPage({super.key});

  @override
  _CategorySubscriptionPageState createState() => _CategorySubscriptionPageState();
}

class _CategorySubscriptionPageState extends State<CategorySubscriptionPage> {
  Color mainColor = const Color(0xff083c74);
  List<EventCategory> categories = [];
  List<bool> subscribedList = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoriesAndSubscriptionStatus();
  }

Future<http.Response> _sendJsonRequest(Map<String, dynamic> requestBody) async {
  HttpClient client = HttpClient();
  String inputData = json.encode(requestBody);
  client.connectionTimeout = Duration(seconds: 30);

  try {
    HttpClientRequest request = await client.postUrl(Uri.parse("http://10.0.2.2:80"));
    request.headers.contentType = ContentType("application", "json", charset: "utf-8");
    request.headers.contentLength = inputData.length;


    if (inputData != null) {
      request.write(inputData);
    }

    HttpClientResponse response = await request.close();
    int contentLength = response.headers.contentLength;
    print('Content Length: $contentLength');

    if (response.statusCode == HttpStatus.ok) {
      String contents = await response.transform(utf8.decoder).join();
      return http.Response(contents, response.statusCode);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print(e);
    throw Exception('Error in _sendJsonRequest: $e');
  } finally {
    client.close();
  }
}

  Future<void> _fetchCategoriesAndSubscriptionStatus() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    final response = await _sendJsonRequest({
      'request_type': 'get_calu_category_names',
      'username': eventProvider.user.getName,
      'checksum': eventProvider.user.checksum,
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> categoriesData = jsonResponse.cast<Map<String, dynamic>>();

      setState(() {
        for (Map<String, dynamic> categoryData in categoriesData) {
          categories.add(EventCategory.fromJson(categoryData));
          subscribedList.add(categoryData['is_subscribed'].isOdd);
        }
      });
      print(categoriesData);
    }
  }

  Future<void> _updateCategorySubscription(EventCategory category, bool isSubscribed) async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    if (!isSubscribed) {
      eventProvider.removeEventsByCategory(category.id);
    } else {
      eventProvider.addCategory(category);
      await getCaluCategoryEvents(category.id, eventProvider);
    }
    await sendUpdateCategorySubscription(eventProvider.user.getName, category.id, isSubscribed, eventProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Category Subscriptions'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          EventCategory category = categories[index];
          bool subscribed = subscribedList[index];
          return ListTile(
            title: Text(category.name),
            trailing: Checkbox(
              value: subscribed,
              onChanged: (bool? value) async {
                setState(() {
                  subscribedList[index] = value!;
                });
                await _updateCategorySubscription(category, value!);
              },
            ),
          );
        },
      ),
    );
  }
}
