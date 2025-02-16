// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart'; // Import the onboarding screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the onboarding screen after a delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24988F), // Background color of the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container for the rounded image
            Container(
              width: 160, // Width of the circle
              height: 160, // Height of the circle
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Make it circular
                color: Color(0xFF24988F), // Background color of the circle
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/handTalker.png', // Path to your image
                  fit: BoxFit.cover, // Cover the circle
                ),
              ),
            ),
            SizedBox(height: 20), // Space between image and text
            Text(
              'Hand Talker App', // Your app name
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}