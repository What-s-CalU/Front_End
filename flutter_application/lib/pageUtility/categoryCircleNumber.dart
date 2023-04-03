import 'package:flutter/material.dart';

class CategoryCircleNumber extends StatelessWidget {
  final Color color;
  final int count;

  const CategoryCircleNumber({super.key, required this.color, required this.count});

  @override
  Container build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}