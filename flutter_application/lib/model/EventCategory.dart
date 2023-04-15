import 'package:flutter/material.dart';

class EventCategory {
  final int id;
  final String name;
  final Color color;
  final int? userID;

  EventCategory({
    required this.id,
    required this.name,
    required this.color,
    this.userID,
  });

  // Getters
  int get getId => id;
  String get getName => name;
  Color get getColor => color;
  int? get getUserID => userID;

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      id: json['id'],
      name: json['name'],
      color: Color(json['color']),
      userID: json['user_id'],
    );
  }
}