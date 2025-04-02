// card_deck.dart
import 'package:flutter/material.dart';
import 'card_back.dart';

class CardDeck extends StatelessWidget {
  final VoidCallback onDrawCard;
  final bool isDrawing;

  const CardDeck({
    Key? key,
    required this.onDrawCard,
    required this.isDrawing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.brown[800],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            color: Colors.brown[600],
            child: Center(
              child: Text(
                "神秘卡匣",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 卡匣中的卡片堆
                Stack(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index * 2.0, top: index * 2.0),
                      child: CardBack(width: 80, height: 110),
                    );
                  }),
                ),
                // 抽卡按鈕
                ElevatedButton(
                  onPressed: isDrawing ? null : onDrawCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "推薦！",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}