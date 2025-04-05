import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fooder/constants.dart';
import 'package:fooder/function/define_restaurant.dart';  // 假設 Restaurant 類型定義在這個檔案中
import 'package:fooder/function/gacha_drawer.dart'; // 引入獨立的抽卡功能
import '../components/card_back.dart';  // 導入卡背設計
import '../components/card_deck.dart';  // 導入卡匣設計

class GachaScreen extends StatefulWidget {
  const GachaScreen({Key? key}) : super(key: key);

  @override
  _GachaScreenState createState() => _GachaScreenState();
}

class _GachaScreenState extends State<GachaScreen> with SingleTickerProviderStateMixin {
  late GachaDrawer _gachaDrawer;
  String _drawnCardName = "按下按鈕進行推薦！";
  String _drawnCardImage = 'lib/assets/show.jpg'; // 預設圖片路徑
  List<Restaurant> _gachaPool = [];
  bool isLoading = true;
  bool _isDrawing = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200), // 3圈動畫的總時長
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _loadRestaurants() async {
    try {
      // 加載 JSON 文件的內容
      _gachaPool = await _loadRestaurantsFromAsset('lib/assets/json/extracted_recommend_restaurants.json');
      _gachaDrawer = GachaDrawer(gachaPool: _gachaPool);
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
      return parseRestaurants(jsonString); // 使用已經定義的 parseRestaurants 函數
    } catch (e) {
      print('加載 $assetPath 失敗: $e');
      return []; // 如果加載失敗，返回空列表
    }
  }

  // 解析餐廳 JSON 資料
  List<Restaurant> parseRestaurants(String jsonString) {
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => Restaurant.fromJson(json)).toList();
  }

  // 抽卡函式
  void _drawCard() {
    setState(() => _isDrawing = true);
    _animationController.reset();
    _animationController.forward();

    Future.delayed(Duration(milliseconds: 1000), () async {
      var result = await _gachaDrawer.drawCard();
      setState(() {
        _drawnCardName = result['name']!;
        _drawnCardImage = result['image']!;
        _isDrawing = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 卡片正面
  Widget _buildCardFront() {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: AppColors.cardBorder, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.network(
          _drawnCardImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.uploadButtonBorder,
              child: Icon(Icons.image_not_supported, size: 100, color: AppColors.uploadButtonIconColor),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardBackground,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 80,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 45),
                  // 顯示抽到的餐廳卡片
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(pi * 2 * _animation.value), // 每個值都乘以 2π 來實現旋轉
                        child: _isDrawing && _animation.value < 1.5
                            ? CardBack()  // 使用卡背設計
                            : _buildCardFront(), // 顯示餐廳卡片正面
                      );
                    },
                  ),
                  SizedBox(height: 35),
                  Text(
                    _isDrawing ? "思考中..." : _drawnCardName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.ratingColor,
                    ),
                  ),
                ],
              ),
            ),
            // 使用卡匣設計
            CardDeck(
              onDrawCard: _drawCard,
              isDrawing: _isDrawing,
            ),
          ],
        ),
      ),
    );
  }
}
