import 'package:flutter/material.dart';
import '../../components/roulette.dart'; // Import the Roulette Component
import '../../components/floating_side_list.dart';
import '../../components/botton.dart';

class Second_Roulette extends StatelessWidget {
  final VoidCallback onToggle;

  Second_Roulette({required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 100,
            ),

            Center(
              child: RouletteComponent(),
            ),
              
            SizedBox(
              height: 100,
            ),

            // Button
            BigButton(
              buttonText: "Reload", // Text on the button
              onPressed: onToggle,
              color: Colors.green, // Button color
              width: 300.0, // Button width
              height: 80.0, // Button height
              textStyle: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        // Floating side list
        FloatingSideList()
      ],
    );
  }
}
