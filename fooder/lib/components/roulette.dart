import 'package:flutter/material.dart';
import 'dart:math';

class RouletteComponent extends StatefulWidget {
  @override
  _RouletteComponentState createState() => _RouletteComponentState();
}

class _RouletteComponentState extends State<RouletteComponent> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _isSpinning = false;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Set duration of spin
    );

    // Rotation Animation
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  // Start or stop the spin
  void _spinWheel() {
    if (_isSpinning) {
      // Stop the spin and reset to a random position
      _controller.stop();
      _controller.value = Random().nextDouble();
    } else {
      // Start spinning
      _controller.repeat();
    }

    setState(() {
      _isSpinning = !_isSpinning;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _spinWheel,
          child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: child,
              );
            },
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.red, Colors.purple, Colors.pink, Colors.black, Colors.blue
                    // You can add more sections or different colors
                  ],
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: Center(
                child: Text(
                  _isSpinning ? "Spinning..." : "Click to Spin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _spinWheel,
          child: Text(_isSpinning ? "Stop" : "Start Spin"),
        ),
      ],
    );
  }
}
