import 'package:flutter/material.dart';
import 'package:fooder/function/define_restaurant.dart';
import '../components/card_stack.dart';
import 'package:flutter/services.dart' show rootBundle;

class Tinder extends StatefulWidget {
  @override
  _TinderState createState() => _TinderState();
}

class _TinderState extends State<Tinder> {
  List<Restaurant> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    try {
      // 加載三個 JSON 文件的內容
      restaurants = await _loadRestaurantsFromAsset('lib/assets/json/extracted_unknown_restaurants.json');
      
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

  Future<List<Restaurant>> _loadRestaurantsFromAsset(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      return parseRestaurants(jsonString); // 使用您已經定義的 parseMeals 函數
    } catch (e) {
      print('加載 $assetPath 失敗: $e');
      return []; // 如果加載失敗，返回空列表
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeableCardStack(restaurants: restaurants),
    );
  }
}
