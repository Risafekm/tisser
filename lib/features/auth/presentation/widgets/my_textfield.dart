// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData? icon;
  final IconData? suffix;
  final bool obscureText;
  final int? maxLines;

  const MyTextFiled({
    super.key,
    required this.controller,
    required this.text,
    this.icon,
    this.suffix,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffix != null ? Icon(suffix) : null,

        // Default border
        border: const OutlineInputBorder(),

        // Enabled border
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),

        // Focused border
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
        ),

        // Disabled border
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),

        // Error border
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),

        // Focused error border
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}
