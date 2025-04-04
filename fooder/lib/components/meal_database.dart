import 'package:flutter/material.dart';
import 'package:fooder/function/define_meal.dart';
import 'meal_list.dart'; // Import the horizontal photo list component
import 'package:fooder/constants.dart'; // Import the colors definition

class PhotoDatabase extends StatelessWidget {
  final String title;
  final List<Meal> meals;

  const PhotoDatabase({Key? key, required this.title, required this.meals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryTextColor, // Set title text color
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: AppColors.cardBackground, // Set the background color for the horizontal photo list container
          child: HorizontalPhotoList(meals: meals),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
