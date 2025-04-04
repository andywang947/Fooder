import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker
import 'package:fooder/function/define_meal.dart';
import 'meal_container.dart'; // Import the PhotoContainer component
import 'package:fooder/constants.dart'; // Import the colors definition

class HorizontalPhotoList extends StatefulWidget {
  final List<Meal> meals;
  final Function(Meal)? onMealAdded; // Add callback for parent component

  const HorizontalPhotoList({
    Key? key,
    required this.meals,
    this.onMealAdded,
  }) : super(key: key);

  @override
  _HorizontalPhotoListState createState() => _HorizontalPhotoListState();
}

class _HorizontalPhotoListState extends State<HorizontalPhotoList> {
  late List<Meal> meals;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    meals = List.from(widget.meals); // Copy the initial list
  }

  @override
  void didUpdateWidget(HorizontalPhotoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update meals list if the parent widget sends new data
    if (widget.meals != oldWidget.meals) {
      setState(() {
        meals = List.from(widget.meals);
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Compress image quality for better performance
      );

      if (pickedFile != null) {
        // Create a new meal object with the picked image
        final newMeal = Meal(
          id: DateTime.now().millisecondsSinceEpoch,  // Generate unique ID
          timestamp: DateTime.now(),
          latitude: 25.0338,  // You may want to fetch the actual location
          longitude: 121.5645,  // You may want to fetch the actual location
          restaurant: "Mr. light 輕食先生",
          feedback: "好吃",
          imageFile: pickedFile.path,
          type: '健康餐盒', // Customize as per your requirement
          description: '這是一個包含雞肉、秋葵、花椰菜、甜地瓜、毛豆和半顆水煮蛋的健康餐盒，淋上泰式風味的醬汁，搭配白飯。', // Customize
          feedback_description: '餐盒配色豐富，雞肉鮮嫩、醬汁酸辣開胃，整體清爽又有飽足感，吃起來很清爽無負擔。',
          calorieEstimation: 550,  // Example estimation
          calorieLevel: '中',  // Example level
          tags: ["健康餐盒", "雞肉", "秋葵", "花椰菜", "甜地瓜", "毛豆", "水煮蛋", "泰式", "低脂"],  // Example tags
          suggestion: '這份餐盒營養均衡，富含蛋白質和膳食纖維，是很好的選擇。建議可以增加一些好的油脂，例如酪梨或堅果，讓營養更完整。',
        );

        // Update the state to trigger a rebuild and display the new image
        setState(() {
          meals.add(newMeal);
        });

        // Notify parent widget if callback provided
        if (widget.onMealAdded != null) {
          widget.onMealAdded!(newMeal);
        }
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        children: [
          SizedBox(
            height: 175,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length + 1, // +1 for the upload button
              itemBuilder: (context, index) {
                if (index < meals.length) {
                  // Display meal
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 115,
                        height: 175,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground, // Set background color for the upload button
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.uploadButtonBorder, // Set border color for the upload button
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: AppColors.uploadButtonIconColor, // Set icon color
                            ),
                            SizedBox(height: 8),
                            Text(
                              '新增相片',
                              style: TextStyle(
                                color: AppColors.uploadButtonIconColor, // Set text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
