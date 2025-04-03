import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fooder/function/define_meal.dart';

class MealContainer extends StatelessWidget {
  final Meal meal;
  final double width;
  final double height;
  final BoxFit fit;

  const MealContainer({
    Key? key,
    required this.meal,
    this.width = 200,
    this.height = 200,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  /// 顯示餐點資訊的彈窗
  void _showMealInfo(BuildContext context, Meal meal) {
    ImageProvider imageProvider;
    
    // 判斷圖片來源 (assets 或 本機路徑)
    if (meal.imageFile.startsWith('lib/assets/')) {
      imageProvider = AssetImage(meal.imageFile);
    } else {
      imageProvider = FileImage(File(meal.imageFile));
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('食物詳情'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 圖片顯示
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // 圓角
                child: Image(
                  image: imageProvider,
                  width: 300, // 設定寬度
                  height: 400, // 設定高度
                  fit: BoxFit.cover, // 確保圖片填滿框架
                  errorBuilder: (context, error, stackTrace) {
                    print('圖片載入錯誤: $error');
                    return Icon(Icons.broken_image, size: 100, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(height: 10), // 加點間距
              Text('類型: ${meal.type}'),
              Text('敘述: ${meal.description}'),
              Text('預測卡路里: ${meal.calorieEstimation} 大卡'),
              Text('卡路里等級: ${meal.calorieLevel}'),
              Text('營養建議: ${meal.suggestion}'),
              Text('標籤: ${meal.tags.join(', ')}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('關閉'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    
    // 判斷圖片來源 (assets 或 本機路徑)
    if (meal.imageFile.startsWith('lib/assets/')) {
      imageProvider = AssetImage(meal.imageFile);
    } else {
      imageProvider = FileImage(File(meal.imageFile));
    }

    return GestureDetector(
      onTap: () => _showMealInfo(context, meal),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
          image: DecorationImage(
            image: imageProvider, // 動態選擇圖片來源
            fit: fit,
          ),
        ),
      ),
    );
  }
}
