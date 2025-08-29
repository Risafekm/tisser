// my_textfield.dart
import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData? icon;
  final Widget? suffix;
  final bool obscureText;
  final int? maxLines;
  final String? Function(String?)? validator; // ✅ added validator

  const MyTextFiled({
    super.key,
    required this.controller,
    required this.text,
    this.icon,
    this.suffix,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ✅ changed from TextField to TextFormField
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator, // ✅ added validator
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffix,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}
