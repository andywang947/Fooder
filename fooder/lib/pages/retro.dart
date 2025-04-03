import 'package:flutter/material.dart';
import 'package:fooder/function/define_meal.dart';
import '../components/meal_database.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fooder/constants.dart'; // 引入顏色定義

class Retro extends StatefulWidget {
  const Retro({Key? key}) : super(key: key);

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
      return parseMeals(jsonString);
    } catch (e) {
      print('加載 $assetPath 失敗: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground, // 設定背景顏色
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: AppColors.loadingColor, // 設定加載指示器顏色
              )
            : SingleChildScrollView(  // 使用 SingleChildScrollView 使內容可滾動
                child: Container(
                  color: AppColors.cardBackground, // 設定卡片背景顏色
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start, // 靠左對齊
                    children: [
                      SizedBox(
                        height: 50,
                        child: Container(color: AppColors.cardBackground), // 設定間距背景顏色
                      ),
                      PhotoDatabase(
                        meals: meals3,
                        title: '2025 3/30 - 現在',
                      ),
                      Divider(color: AppColors.dividerColor),
                      PhotoDatabase(
                        meals: meals2,
                        title: '2025 3/23 - 3/29',
                      ),
                      Divider(color: AppColors.dividerColor),
                      PhotoDatabase(
                        meals: meals1,
                        title: '2025 3/16 - 3/22',
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
