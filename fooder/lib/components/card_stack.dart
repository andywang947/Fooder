import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'card.dart';

class SwipeableCardStack extends StatelessWidget {
  final List<FullScreenCard> cards = [
    FullScreenCard(
      imagePath: "lib/assets/meal_photos/1.jpg",
      name: "Sunset Beach",
      type: "Tourist Spot",
      distance: "5 km away",
      tags: ["Scenic", "Family-friendly", "Relaxing"],
      description: "A beautiful place to enjoy the sunset.",
    ),
    FullScreenCard(
      imagePath: "lib/assets/meal_photos/2.jpg",
      name: "Sunset Beach",
      type: "Tourist Spot",
      distance: "5 km away",
      tags: ["Scenic", "Family-friendly", "Relaxing"],
      description: "A beautiful place to enjoy the sunset.",
    ),
    FullScreenCard(
      imagePath: "lib/assets/meal_photos/3.jpg",
      name: "Sunset Beach",
      type: "Tourist Spot",
      distance: "5 km away",
      tags: ["Scenic", "Family-friendly", "Relaxing"],
      description: "A beautiful place to enjoy the sunset.",
    ),
    FullScreenCard(
      imagePath: "lib/assets/meal_photos/4.jpg",
      name: "Sunset Beach",
      type: "Tourist Spot",
      distance: "5 km away",
      tags: ["Scenic", "Family-friendly", "Relaxing"],
      description: "A beautiful place to enjoy the sunset.",
    ),
    // Add more FullScreenCard instances as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: CardSwiper(
            cardsCount: cards.length,
            padding:	EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
            onSwipe: (previousIndex, currentIndex, direction) {
              if (direction == CardSwiperDirection.left) {
                print("Swiped Left (Dislike)");
              } else if (direction == CardSwiperDirection.right) {
                print("Swiped Right (Like)");
              } else if (direction == CardSwiperDirection.top) {
                print("Swiped Up (More Info)");
              }
              return true; // Return true to confirm the swipe action
            },
            onUndo: (previousIndex, currentIndex, direction) {
              print("Undo swipe from $direction");
              return true; // Return true to confirm the undo action
            },
          ),
        ),
      ),
    );
  }
}
