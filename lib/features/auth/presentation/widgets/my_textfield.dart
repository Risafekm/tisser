// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData? icon;
  final bool obscureText;

  const MyTextFiled({
    super.key,
    required this.controller,
    required this.text,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: text,
      ),
    );
  }
}
