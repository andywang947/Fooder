import 'package:flutter/material.dart';
import '../../components/botton.dart'; // Import the BigButton component

class First_Roulette extends StatelessWidget {
  final VoidCallback onToggle;

  First_Roulette({required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigButton(
          buttonText: "Click Me", // Button text
          onPressed: onToggle,
          color: Colors.green, // Button color
          width: 300.0, // Button width
          height: 80.0, // Button height
          textStyle: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}