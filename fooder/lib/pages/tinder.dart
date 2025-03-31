import 'package:flutter/material.dart';
import '../components/card_stack.dart';

class Tinder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeableCardStack(),
    );
  }
}
