import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  ColorPicker({required this.initialColor, required this.onColorChanged});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: colors
          .map(
            (color) => InkWell(
              onTap: () {
                setState(() {
                  _currentColor = color;
                  widget.onColorChanged(color);
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _currentColor == color
                        ? Colors.black
                        : Colors.transparent,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
