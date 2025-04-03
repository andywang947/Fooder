import 'package:flutter/material.dart';
import 'package:fooder/function/define_restaurant.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'card.dart';

class SwipeableCardStack extends StatelessWidget {
  final List<Restaurant> restaurants;

  const SwipeableCardStack({
    Key? key,
    required this.restaurants
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: restaurants.isEmpty
            ? Center(
                child: Text(
                  "目前沒有餐廳可以選擇",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : CardSwiper(
                cardsCount: restaurants.length,
                numberOfCardsDisplayed: restaurants.length < 3 ? restaurants.length : 3, // 限制顯示卡片數量
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
                    FullScreenCard(restaurant: restaurants[index]),
                onSwipe: (previousIndex, currentIndex, direction) {
                  if (direction == CardSwiperDirection.left) {
                    print("Swiped Left (Dislike) for ${restaurants[previousIndex].name}");
                  } else if (direction == CardSwiperDirection.right) {
                    print("Swiped Right (Like) for ${restaurants[previousIndex].name}");
                  } else if (direction == CardSwiperDirection.top) {
                    print("Swiped Up (More Info) for ${restaurants[previousIndex].name}");
                  }
                  return true; // 確認滑動行為
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  print("Undo swipe from $direction for ${restaurants[currentIndex].name}");
                  return true;
                },
              ),
      ),
    );
  }
}
