import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData icon;
  final String? initialValue;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    required this.icon,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}