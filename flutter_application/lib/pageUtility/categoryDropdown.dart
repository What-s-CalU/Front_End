import 'package:flutter/material.dart';
import 'package:flutter_application_1/httpRequests/httpRequests.dart';
import 'package:flutter_application_1/pageUtility/colorPicker.dart';
import 'package:provider/provider.dart';
import '../provider/eventProvider.dart';

class CategoryDropdown extends StatefulWidget {
  final ValueChanged<int?> onCategoryChanged;
  final int? selectedCategory;
  const CategoryDropdown({required this.onCategoryChanged, this.selectedCategory});
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  int? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final customCategories = eventProvider.getCustomEventCategories();

    return DropdownButtonFormField<int?>(
      decoration: const InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      value: _selectedCategory,
      items: [
        const DropdownMenuItem<int>(
          value: null,
          child: Text('No category'),
        ),
        ...customCategories.map<DropdownMenuItem<int>>(
          (category) => DropdownMenuItem<int>(
            value: category.getId,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.getName),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: eventProvider.getCategoryColorById(category.getId),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        const DropdownMenuItem<int>(
          value: -1,
          child: Text('Add new category'),
        ),
      ],
      onChanged: (value) async {
        if (value == -1) {
          int? newCategory = await _showAddNewCategoryDialog(context);
          if (newCategory != null) {
            setState(() {
              _selectedCategory = newCategory;
              widget.onCategoryChanged(_selectedCategory);
            });
          }
        } else {
          setState(() {
            _selectedCategory = value;
            widget.onCategoryChanged(_selectedCategory);
          });
        }
      },
    );
  }
}

Future<int?> _showAddNewCategoryDialog(BuildContext context) async {
  final TextEditingController categoryNameController = TextEditingController();
  Color selectedColor = Colors.blue;

  return showDialog<int>(
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
            onPressed: () async {
              if (categoryNameController.text.isNotEmpty) {
                // Add new category with the color
                final eventProvider = Provider.of<EventProvider>(context, listen: false);
                int categoryId = await sendAddCategory(eventProvider.user.getName, categoryNameController.text, selectedColor, eventProvider);

                Navigator.of(context).pop(categoryId);
              }
            },
          ),
        ],
      );
    },
  );
}
