import 'package:flutter/material.dart';
import 'package:fooder/function/define_restaurant.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'card.dart';
import 'package:fooder/constants.dart';

class SwipeableCardStack extends StatelessWidget {
  final List<Restaurant> restaurants;

  const SwipeableCardStack({
    Key? key,
    required this.restaurants
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground, // 整體背景色
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: restaurants.isEmpty
            ? Center(
                child: Text(
                  "目前沒有餐廳可以選擇",
                  style: TextStyle(
                    fontSize: 18, 
                    color: AppColors.textColor, // 文字顏色改為白色
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : CardSwiper(
                cardsCount: restaurants.length,
                numberOfCardsDisplayed: restaurants.length < 3 ? restaurants.length : 3, // 限制顯示卡片數量
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondBackgroundColor, // 卡片背景色
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: FullScreenCard(restaurant: restaurants[index]),
                    ),
                onSwipe: (previousIndex, currentIndex, direction) {
                  String actionText = "";
                  Color actionColor = Colors.white;
                  if (direction == CardSwiperDirection.left) {
                    actionText = "不喜歡 👎";
                    actionColor = Colors.red;
                  } else if (direction == CardSwiperDirection.right) {
                    actionText = "喜歡 ❤️";
                    actionColor = Colors.green;
                  } else if (direction == CardSwiperDirection.top) {
                    actionText = "🎉 超級喜歡 🎉";
                    actionColor = Colors.blue;
                  } else {
                  }
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "$actionText: ${restaurants[previousIndex].name}",
                        style: TextStyle(fontSize: 16, color: AppColors.textColor),
                      ),
                      backgroundColor: actionColor,
                      duration: Duration(milliseconds: 800),
                    ),
                  );
                  return true; // 確認滑動行為
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "撤銷滑動: ${restaurants[currentIndex].name}",
                        style: TextStyle(fontSize: 16, color: AppColors.textColor),
                      ),
                      backgroundColor: AppColors.dialogBackgroundColor,
                      duration: Duration(milliseconds: 800),
                    ),
                  );
                  return true;
                },
              ),
      ),
    );
  }
}
