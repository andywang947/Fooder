import 'package:flutter/material.dart';
import 'package:fooder/function/define_meal.dart';
import 'meal_list.dart'; // Import the horizontal photo list component

class PhotoDatabase extends StatelessWidget {
  final String title;
  final List<Meal> meals;

  PhotoDatabase({required this.title, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        HorizontalPhotoList(meals: meals),
        SizedBox(height: 20),
      ],
    );
  }
}
