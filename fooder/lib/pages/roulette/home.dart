import 'package:flutter/material.dart';
import 'first.dart';
import 'second.dart';

class Roulette extends StatefulWidget {
  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  bool showWidgetA = true; // Default to Widget A

  void toggleWidget() {
    setState(() {
      showWidgetA = !showWidgetA;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Roulette Page")),
      body: Center(
        child: showWidgetA
            ? First_Roulette(onToggle: toggleWidget) // Show Widget A
            : Second_Roulette(onToggle: toggleWidget), // Show Widget B
      ),
    );
  }
}
