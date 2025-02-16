import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen
// Import the color palette screen
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette App',
      theme: ThemeData(
        primaryColor: Color(0xFF24988F), // Primary Color
        hintColor: Color(0xFF8F2498), // Complementary Color
      ),
      home: SplashScreen(), // Set the splash screen as the home
    );
  }
}