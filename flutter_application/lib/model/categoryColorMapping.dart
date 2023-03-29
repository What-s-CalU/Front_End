import 'package:flutter/material.dart';

class CategoryColorMapping {
  final Map<String, Color> _categoryColorMapping = {};

  Color getColorForCategory(String category) {
    if (_categoryColorMapping.containsKey(category)) {
      return _categoryColorMapping[category]!;
    } else {
      return Colors.blue;
    }
  }

  void setColorForCategory(String category, Color color) {
    _categoryColorMapping[category] = color;
  }
}
