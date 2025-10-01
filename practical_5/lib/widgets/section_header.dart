import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color? color;

  const SectionHeader({
    super.key,
    required this.title,
    this.fontSize = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.blue.shade700,
        ),
      ),
    );
  }
}