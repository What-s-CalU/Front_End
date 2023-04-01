import 'package:flutter/material.dart';

class CategorySubscriptionPage extends StatefulWidget {
  const CategorySubscriptionPage({Key? key}) : super(key: key);

  @override
  _CategorySubscriptionPageState createState() => _CategorySubscriptionPageState();
}

class _CategorySubscriptionPageState extends State<CategorySubscriptionPage> {
  Color mainColor = const Color(0xff083c74);
  List<String> categories = ['Category1', 'Category2', 'Category3', 'Category4', 'Category5'];
  Map<String, bool> subscribedCategories = {};

  @override
  void initState() {
    super.initState();
    for (String category in categories) {
      subscribedCategories[category] = false;
    }
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
          return ListTile(
            title: Text(category),
            trailing: Checkbox(
              value: subscribedCategories[category],
              onChanged: (bool? value) {
                setState(() {
                  subscribedCategories[category] = value!;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
