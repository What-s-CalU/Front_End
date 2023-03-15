import 'package:flutter/material.dart';

class Event {
  final DateTime startTime;
  final DateTime endTime;
  final String subject;
  final Color color;
  final String? description;
  final int? subscriptions;
  final String? category;
  Event({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.color,
    this.description,
    this.subscriptions,
    this.category,
  });
}
