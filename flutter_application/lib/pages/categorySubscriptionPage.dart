import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:provider/provider.dart';
import '../httpRequests/httpRequests.dart';

class CategorySubscriptionPage extends StatefulWidget {
  const CategorySubscriptionPage({super.key});

  @override
  _CategorySubscriptionPageState createState() => _CategorySubscriptionPageState();
}

class _CategorySubscriptionPageState extends State<CategorySubscriptionPage> {
  Color mainColor = const Color(0xff083c74);
  List<String> categories     = [];
  List<bool>   subscribedList = [];
  @override
  void initState() {
    super.initState();
    _fetchCategoriesAndSubscriptionStatus();
  }

  Future<void> _fetchCategoriesAndSubscriptionStatus() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    List<Map<String, dynamic>> categoriesData = await sendGetCaluCategoryNamesWithSubscriptionStatus(eventProvider.username);
    setState(() {
      for (Map<String, dynamic> categoryData in categoriesData) {
        String categoryName = categoryData['name'];
        bool isSubscribed = categoryData['is_subscribed'].isOdd;
        categories.add(categoryName);
        subscribedList.add(isSubscribed);
      }
    });
    print(categoriesData);
  }

  Future<void> _updateCategorySubscription(String categoryName, bool isSubscribed) async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    if(!isSubscribed){
      eventProvider.removeEventsByCategory(categoryName);
    } else {
      await getCaluCategoryEvents(categoryName, eventProvider);
    }
    await sendUpdateCategorySubscription(eventProvider.username, categoryName, isSubscribed);
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
          String category = categories[index];
          bool subscribed = subscribedList[index];
          return ListTile(
            title: Text(category),
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