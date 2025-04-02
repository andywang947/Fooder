import 'package:flutter/material.dart';
import 'package:fooder/function/define_meal.dart';
import '../components/meal_database.dart';
import 'package:flutter/services.dart' show rootBundle;

class Retro extends StatefulWidget {
  @override
  _RetroState createState() => _RetroState();
}

class _RetroState extends State<Retro> {
  List<Meal> meals1 = [];
  List<Meal> meals2 = [];
  List<Meal> meals3 = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    try {
      // 加載三個 JSON 文件的內容
      meals1 = await _loadMealsFromAsset('lib/assets/json/meals1.json');
      meals2 = await _loadMealsFromAsset('lib/assets/json/meals2.json');
      meals3 = await _loadMealsFromAsset('lib/assets/json/meals3.json');
      
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('加載數據時出錯: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<Meal>> _loadMealsFromAsset(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      return parseMeals(jsonString); // 使用您已經定義的 parseMeals 函數
    } catch (e) {
      print('加載 $assetPath 失敗: $e');
      return []; // 如果加載失敗，返回空列表
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // 數據加載時顯示加載指示器
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  PhotoDatabase(meals: meals3, title: '2025 3/30 - Now'),
                  PhotoDatabase(meals: meals2, title: '2025 3/23 - 3/29'),
                  PhotoDatabase(meals: meals1, title: '2025 3/16 - 3/22'),
                ],
              ),
      ),
    );
  }
}