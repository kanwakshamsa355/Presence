import 'package:flutter/material.dart';
import 'package:hand_talker_app/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _titles = [
    'Learn Hand Gestures',
    'Practice with Drawings',
    'Communicate Together',
  ];

  final List<String> _descriptions = [
    'Understand basic hand gestures to communicate effectively.',
    'Use hand-drawn references to perfect your signing skills.',
    'Connect with others using hand gestures.',
  ];

  final List<String> _images = [
    'assets/images/greeting.jpg', // Hand greeting image
    'assets/images/handDrawn.jpg', // Hand-drawn references
    'assets/images/together.jpg', // Communication together
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _images[index],
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Text(
                      _titles[index],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _descriptions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Skip'),
              ),
              TextButton(
                onPressed: () {
                  if (_currentPage < _titles.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
                child: Text(_currentPage == _titles.length - 1 ? 'Get Started' : 'Next'),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
