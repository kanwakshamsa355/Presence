import 'package:flutter/material.dart';

class ColorPaletteScreen extends StatelessWidget {
  const ColorPaletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Palette'),
        backgroundColor: Color(0xFF24988F), // Primary Color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColorBox(color: Color(0xFF24988F), label: 'Primary Color'),
            ColorBox(color: Color(0xFF8F2498), label: 'Complementary Color'), // Adjusted
            ColorBox(color: Color(0xFF2498A8), label: 'Analogous Color 1'), // Adjusted
            ColorBox(color: Color(0xFF24988F), label: 'Analogous Color 2'), // Adjusted
            ColorBox(color: Color(0xFFA82498), label: 'Triadic Color 1'), // Adjusted
            ColorBox(color: Color(0xFF2498A8), label: 'Triadic Color 2'), // Adjusted
          ],
        ),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const ColorBox({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 200,
      height: 100,
      color: color,
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}