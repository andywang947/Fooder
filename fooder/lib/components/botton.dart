import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final TextStyle textStyle;

  // Constructor to allow customization
  const BigButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.color = Colors.blue, // Default color
    this.width = 250.0, // Default width
    this.height = 70.0, // Default height
    this.textStyle = const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
        ),
        child: Text(
          buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
