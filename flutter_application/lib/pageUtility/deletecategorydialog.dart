import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../httpRequests/httpRequests.dart';
import '../provider/eventProvider.dart';

void showDeleteCategoryDialog(BuildContext context, int categoryId, EventProvider eventProvider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Category'),
        content: Text('Are you sure you want to delete this category? All events in the category will be deleted.'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () async {
              await sendDeleteCategory(categoryId, eventProvider);
              eventProvider.removeEventsByCategory(categoryId);
              eventProvider.removeCategoryById(categoryId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}