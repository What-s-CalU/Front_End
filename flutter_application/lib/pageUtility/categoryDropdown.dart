import 'package:flutter/material.dart';
import 'package:flutter_application_1/pageUtility/colorPicker.dart';
import 'package:provider/provider.dart';
import '../provider/eventProvider.dart';

class CategoryDropdown extends StatefulWidget {
  final ValueChanged<String?> onCategoryChanged;

  CategoryDropdown({required this.onCategoryChanged});
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? _selectedCategory;
  bool newCategoryAdded = false;

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final customCategories = eventProvider.getCustomEventCategories();

    return DropdownButtonFormField<String?>(
      decoration: const InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      value: _selectedCategory,
      items: [
        if (newCategoryAdded == false)
          const DropdownMenuItem<String?>(
            value: null,
            child: Text('No category'),
          ),
        ...customCategories.map<DropdownMenuItem<String?>>(
          (category) => DropdownMenuItem<String?>(
            value: category,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: eventProvider.categoryColorMapping.getColorForCategory(category),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (newCategoryAdded == false)
          const DropdownMenuItem<String?>(
            value: '_add_new_category_',
            child: Text('Add new category'),
          ),
        if (_selectedCategory != null)
          if (eventProvider.isNotCustomCategory(_selectedCategory!))
            DropdownMenuItem<String?>(
              value: _selectedCategory,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedCategory!),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: eventProvider.categoryColorMapping.getColorForCategory(_selectedCategory!),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
      ],
      onChanged: (value) async {
        if (value == '_add_new_category_') {
          String? newCategory = await _showAddNewCategoryDialog(context);
          if (newCategory != null) {
            setState(() {
              _selectedCategory = newCategory;
              newCategoryAdded = true;
            });
            widget.onCategoryChanged(newCategory);
          }
        } else {
          setState(() {
            _selectedCategory = value;
          });
          widget.onCategoryChanged(value);
        }
      },
    );
  }
}

Future<String?> _showAddNewCategoryDialog(BuildContext context) async {
  final TextEditingController categoryNameController = TextEditingController();
  Color selectedColor = Colors.blue;

  return showDialog<String?>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add New Category'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: categoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'Enter category name',
                ),
              ),
              const SizedBox(height: 12),
              ColorPicker(
                initialColor: selectedColor,
                onColorChanged: (color) {
                  selectedColor = color;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (categoryNameController.text.isNotEmpty) {
                // Add new category with the color
                final eventProvider = Provider.of<EventProvider>(context, listen: false);
                eventProvider.addCustomEventCategory(
                  categoryNameController.text,
                  selectedColor,
                );

                Navigator.of(context).pop(categoryNameController.text);
              }
            },
          ),
        ],
      );
    },
  );
}
