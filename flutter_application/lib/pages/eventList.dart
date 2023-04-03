import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Events.dart';
import 'package:flutter_application_1/pages/AddEventPage.dart';
import 'package:flutter_application_1/provider/eventProvider.dart';
import 'package:flutter_application_1/pageUtility/eventListUtil.dart';
import 'package:provider/provider.dart';
import '../pageUtility/categoryCircleNumber.dart';
import '../pageUtility/navigationBar.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  Color mainColor = const Color(0xff083c74);
  String? selectedCategory;
  int daysAwayFilter = 7;

  List<String> _caluCategories = [];
  List<String> _customCategories = [];

  String getAppBarTitle() {
    if (selectedCategory == null) {
      return 'List';
    } else {
      return 'List - $selectedCategory';
    }
  }

  void updateCategories() {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    setState(() {
      _caluCategories = eventProvider.getCaluEventCategories();
      _customCategories = eventProvider.getCustomEventCategories();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    List<Event> filteredEvents = eventProvider.getEventsByDaysAway(daysAwayFilter);

    if (selectedCategory != null) {
      filteredEvents = filteredEvents.where((event) => event.category == selectedCategory).toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          getAppBarTitle(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventPage()));
            },
          ),
          PopupMenuButton<int>(
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text('1 day'),
              ),
              const PopupMenuItem<int>(
                value: 7,
                child: Text('7 days'),
              ),
              const PopupMenuItem<int>(
                value: 30,
                child: Text('30 days'),
              ),
            ],
            onSelected: (int value) {
              setState(() {
                daysAwayFilter = value;
              });
            },
            icon: const Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: filteredEvents
                .map((event) => EventContainer(
                      event: event,
                    ))
                .toList(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: mainColor,
              ),
              child: const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ExpansionTile(
              title: const Text('CalU', style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.school, color: mainColor),
              children: _caluCategories.map((category) {
                int categoryCount = eventProvider.getNumberOfEventsByCategory(category, daysAwayFilter);
                return ListTile(
                  title: Text(category, style: const TextStyle(fontSize: 16)),
                  trailing: CategoryCircleNumber(color: eventProvider.categoryColorMapping.getColorForCategory(category), count: categoryCount),
                  leading: const SizedBox(width: 40),
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text('Custom', style: TextStyle(fontSize: 18)),
              leading: Icon(Icons.create, color: mainColor),
              children: _customCategories.map((category) {
              int categoryCount = eventProvider.getNumberOfEventsByCategory(category, daysAwayFilter);
                return ListTile(
                  title: Text(category, style: const TextStyle(fontSize: 16)),
                  leading: const SizedBox(width: 40),
                  trailing: CategoryCircleNumber(color: eventProvider.categoryColorMapping.getColorForCategory(category), count: categoryCount),
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: customBottomNavigationBar(context),
    );
  }
}