// card_deck.dart
import 'package:flutter/material.dart';
import 'card_back.dart';
import 'package:fooder/constants.dart';

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
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardDeck,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardDeckTop,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            color: AppColors.cardDeckTop,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 卡匣中的卡片堆
                Stack(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: index * 3.0, top: index * 1.0),
                      child: CardBack(width: 80, height: 110),
                    );
                  }),
                ),
                SizedBox(width: 50,),
                // 抽卡按鈕
                ElevatedButton(
                  onPressed: isDrawing
                      ? () {} // 空函式，按下沒事發生，但保留樣式
                      : onDrawCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardBorder,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "推 薦",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonTextColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}