import 'package:flutter/material.dart';

// CustomAppBar to avoid conflicts with Flutter's built-in AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold widget is not needed for an individual AppBar
    return Scaffold(
      // Title of the app bar
      appBar: AppBar(
        title: const Text(
          'Flutter Task Tracker',
          // Styling the title with specific color, size, and weight
          style: TextStyle(
            color: Color(0xFFDAFFFB),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Centering the title within the app bar
        centerTitle: true,
        // Background color of the app bar
        backgroundColor: const Color(0xFF64CCC5),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
