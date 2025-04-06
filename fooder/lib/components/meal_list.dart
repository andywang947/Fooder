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
        imageQuality: 80,
      );

      if (pickedFile != null) {
        // 顯示對話框選擇 feedback
        final feedback = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            String? selectedValue;
            String customFeedback = '';

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('  這餐你覺得...'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: Text('超級好吃'),
                        value: '超級好吃',
                        groupValue: selectedValue,
                        onChanged: (value) => setState(() => selectedValue = value),
                      ),
                      RadioListTile<String>(
                        title: Text('好吃'),
                        value: '好吃',
                        groupValue: selectedValue,
                        onChanged: (value) => setState(() => selectedValue = value),
                      ),
                      RadioListTile<String>(
                        title: Text('普通'),
                        value: '普通',
                        groupValue: selectedValue,
                        onChanged: (value) => setState(() => selectedValue = value),
                      ),
                      RadioListTile<String>(
                        title: Text('不好吃'),
                        value: '不好吃',
                        groupValue: selectedValue,
                        onChanged: (value) => setState(() => selectedValue = value),
                      ),
                      RadioListTile<String>(
                        title: Text('其他...'),
                        value: '其他',
                        groupValue: selectedValue,
                        onChanged: (value) => setState(() => selectedValue = value),
                      ),
                      if (selectedValue == '其他')
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) => customFeedback = value,
                                decoration: InputDecoration(
                                  hintText: '請輸入你的想法...',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('取消'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedValue == null) return;
                        if (selectedValue == '其他') {
                          if (customFeedback.trim().isNotEmpty) {
                            Navigator.of(context).pop(customFeedback.trim());
                          }
                        } else {
                          Navigator.of(context).pop(selectedValue);
                        }
                      },
                      child: Text('送出'),
                    ),
                  ],
                );
              },
            );
          },
        );

        // 如果使用者有選 feedback 才建立 meal
        if (feedback != null) {
          // 顯示 loading
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Dialog(
                backgroundColor: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 18),
                      Text(
                        '生成式AI處理中，請稍候...',
                        style: TextStyle(color: AppColors.secondaryTextColor, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          await Future.delayed(const Duration(seconds: 3));

          final newMeal = Meal(
            id: DateTime.now().millisecondsSinceEpoch,
            timestamp: DateTime.now(),
            latitude: 25.0338,
            longitude: 121.5645,
            restaurant: "Mr. light 輕食先生",
            feedback: feedback, // 來自使用者選擇
            imageFile: pickedFile.path,
            type: '健康餐盒',
            description: '這是一個包含雞肉、秋葵、花椰菜、甜地瓜、毛豆和半顆水煮蛋的健康餐盒，淋上泰式風味的醬汁，搭配白飯。',
            feedback_description: '餐盒配色豐富，雞肉鮮嫩、醬汁酸辣開胃，整體清爽又有飽足感，吃起來很清爽無負擔。',
            calorieEstimation: 550,
            calorieLevel: '中',
            tags: ["健康餐盒", "雞肉", "秋葵", "花椰菜", "甜地瓜", "毛豆", "水煮蛋", "泰式", "低脂"],
            suggestion: '這份餐盒營養均衡，富含蛋白質和膳食纖維，是很好的選擇。建議可以增加一些好的油脂，例如酪梨或堅果，讓營養更完整。',
          );

          setState(() {
            meals.add(newMeal);
          });

          // 關閉 loading 對話框
          Navigator.of(context).pop();

          if (widget.onMealAdded != null) {
            widget.onMealAdded!(newMeal);
          }
        }
      }
    } catch (e) {
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
                              '上傳照片',
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
