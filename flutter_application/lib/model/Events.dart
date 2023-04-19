class Event {
  final int id;
  DateTime startTime;
  DateTime endTime;
  String title;
  String? description;
  int? categoryID;
  bool isCustom;
  bool? flag;

  Event({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.title,
    this.description,
    required this.categoryID,
    required this.isCustom,
    this.flag,
  });

  factory Event.fromDict(Map<String, dynamic> eventDict) {
    return Event(
      id: eventDict['id'],
      startTime: DateTime.parse(eventDict['start_time']),
      endTime: DateTime.parse(eventDict['end_time']),
      title: eventDict['title'],
      description: eventDict['description'],
      categoryID: eventDict['categoryID'],
      isCustom: eventDict['isCustom'] == 1,
      flag: eventDict['flag'] == 1,
    );
  }
}
