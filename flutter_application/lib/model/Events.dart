import 'package:flutter/material.dart';

class Event {
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final Color color;
  final String? description;
  final String? category;
  final bool isCustom;
  Event({
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.color,
    this.description,
    this.category,
    required this.isCustom,
  });
}
