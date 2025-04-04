import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fooder/constants.dart';
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
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              // 圖片顯示
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // 圓角
                child: Image(
                  image: imageProvider,
                  width: 300, // 設定寬度
                  height: 350, // 設定高度
                  fit: BoxFit.cover, // 確保圖片填滿框架
                  errorBuilder: (context, error, stackTrace) {
                    print('圖片載入錯誤：$error');
                    return Icon(Icons.broken_image, size: 100, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(height: 10), // 加點間距
              // 類型
              Text(
                meal.restaurant,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              // 敘述
              Text(
                meal.feedback_description,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  // 卡路里等級 (Chip)
                  Text(
                    '卡路里等級：',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Chip(
                    label: Text(meal.calorieLevel),
                    backgroundColor: _getCalorieLevelColor(meal.calorieLevel),
                    labelStyle: TextStyle(fontSize: 12, color: AppColors.chipTextColor, fontFamily: 'GenSenRounded'),
                    labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0), // 縮小內邊距
                    visualDensity: VisualDensity(horizontal: -2, vertical: -2), // 調整緊湊度
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 讓 Chip 更小
                  ),
                  SizedBox(width: 20,),
                  // 預測卡路里
                  Text(
                    '預測卡路里：${meal.calorieEstimation}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '大卡',
                    style: TextStyle(fontSize: 12,),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // 營養建議
              Text(
                '營養建議：',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondaryTextColor,
                  borderRadius: BorderRadius.circular(8), // 圓角設為 8
                ),
                child: Text(meal.suggestion, style: TextStyle(fontSize: 13, color: AppColors.dividerColor),),
              ),
              SizedBox(height: 10),
              // 標籤 (Tags)
              Wrap(
                spacing: 1,
                runSpacing: 1,
                children: meal.tags.map((tag) {
                  return Chip(
                    label: Text(tag, style: TextStyle(fontSize: 12, color: AppColors.chipTextColor, fontFamily: 'GenSenRounded'),),
                    backgroundColor: AppColors.chipBackgroundColor,
                    labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0), // 縮小內邊距
                    visualDensity: VisualDensity(horizontal: -2, vertical: -2), // 調整緊湊度
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 讓 Chip 更小
                  );
                }).toList(),
              ),
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

// 這是用來取得不同卡路里等級對應顏色的函式
Color _getCalorieLevelColor(String level) {
  switch (level) {
    case '低':
      return Colors.green;
    case '中低':
      return Colors.lightGreen;
    case '中':
      return const Color.fromARGB(255, 255, 196, 0);
    case '中高':
      return const Color.fromARGB(255, 255, 136, 0);
    case '高':
      return const Color.fromARGB(255, 241, 17, 1);
    case '超高':
      return const Color.fromARGB(255, 146, 0, 175);
    default:
      return Colors.grey;
  }
}