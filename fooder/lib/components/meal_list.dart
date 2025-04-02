import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker
import 'package:fooder/function/define_meal.dart';
import 'meal_container.dart'; // Import the PhotoContainer component

class HorizontalPhotoList extends StatefulWidget {
  final List<Meal> meals;

  const HorizontalPhotoList({
    Key? key,
    required this.meals,
  }) : super(key: key);

  @override
  _HorizontalPhotoListState createState() => _HorizontalPhotoListState();
}

class _HorizontalPhotoListState extends State<HorizontalPhotoList> {
  List<Meal> meals = [];

  @override
  void initState() {
    super.initState();
    meals = List.from(widget.meals); // Copy the initial list
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Simulate meal data for the new meal
      final newMeal = Meal(
        id: DateTime.now().millisecondsSinceEpoch,  // Generate unique ID
        timestamp: DateTime.now(),
        latitude: 0.0,  // You may want to fetch the actual location
        longitude: 0.0,  // You may want to fetch the actual location
        imageFile: pickedFile.path,
        type: 'New Meal', // Customize as per your requirement
        description: 'A new meal added from the gallery', // Customize
        calorieEstimation: 500,  // Example estimation
        calorieLevel: 'Medium',  // Example level
        tags: ['New', 'Gallery', 'Image'],  // Example tags
        suggestion: 'Enjoy your meal!',
      );

      setState(() {
        meals.add(newMeal); // Add the new meal to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0), // Add left & right margin
      child: Column(
        children: [
          SizedBox(
            height: 175, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length + 1, // +1 for the upload button
              itemBuilder: (context, index) {
                if (index < meals.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MealContainer(
                      meal: meals[index],
                      width: 115,
                      height: 175,
                    ),
                  );
                } else {
                  // Upload Button
                  return GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 115,
                      height: 175,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add_a_photo, size: 40, color: const Color.fromARGB(137, 230, 230, 230)),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
