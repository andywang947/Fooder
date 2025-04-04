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
      backgroundColor: AppColors.cardBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // 讓子項目靠左
        children: [
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // 加左右邊距
            child: Text(
              '2025',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.loadingColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      color: AppColors.cardBackground,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PhotoDatabase(
                            meals: meals3,
                            title: '3/30 - 現在',
                          ),
                          Divider(color: AppColors.dividerColor),
                          SizedBox(height: 12,),
                          PhotoDatabase(
                            meals: meals2,
                            title: '3/23 - 3/29',
                          ),
                          Divider(color: AppColors.dividerColor),
                          SizedBox(height: 12,),
                          PhotoDatabase(
                            meals: meals1,
                            title: '3/16 - 3/22',
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
