import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fooder/constants.dart';
import 'package:fooder/function/define_restaurant.dart';  // 假設 Restaurant 類型定義在這個檔案中
import '../components/card_back.dart';  // 導入卡背設計
import '../components/card_deck.dart';  // 導入卡匣設計

class GachaScreen extends StatefulWidget {
  const GachaScreen({Key? key}) : super(key: key);

  @override
  _GachaScreenState createState() => _GachaScreenState();
}

class _GachaScreenState extends State<GachaScreen> with SingleTickerProviderStateMixin {
  final Random _random = Random();
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
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _loadRestaurants() async {
    try {
      // 加載 JSON 文件的內容
      _gachaPool = await _loadRestaurantsFromAsset('lib/assets/json/extracted_recommend_restaurants.json');
      
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
    setState(() {
      _isDrawing = true;
    });

    _animationController.reset();
    _animationController.forward();

    // 延遲顯示結果，營造抽卡感
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        int index = _random.nextInt(_gachaPool.length); // 隨機選擇餐廳
        Restaurant selectedRestaurant = _gachaPool[index];
        _drawnCardName = selectedRestaurant.name;

        // If photoUrls is not empty, use the first photo reference. Else, use a default image.
        _drawnCardImage = selectedRestaurant.photoUrls.isNotEmpty
            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${selectedRestaurant.photoUrls[0]}&key=YOUR_API_KEY'
            : 'lib/assets/show.jpg';
        
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
      width: 250,
      height: 350,
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
                  Text(
                    "推薦的餐廳：",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.secondaryTextColor),
                  ),
                  SizedBox(height: 45),
                  // 顯示抽到的餐廳卡片
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(_isDrawing ? pi * _animation.value : 0),
                        child: _isDrawing && _animation.value < 0.5
                            ? CardBack()  // 使用卡背設計
                            : _buildCardFront(), // 顯示餐廳卡片正面
                      );
                    },
                  ),
                  SizedBox(height: 45),
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