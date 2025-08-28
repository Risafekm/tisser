// features/lead/presentation/home_page.dart
import 'package:flutter/material.dart';
import 'package:tisser_app/features/bottom_bar/main_activity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: MainBottomBar());
  }
}
