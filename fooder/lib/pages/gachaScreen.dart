import 'dart:math';
import 'package:flutter/material.dart';
import '../components/card_back.dart';  // 導入卡背設計
import '../components/card_deck.dart';  // 導入卡匣設計

class GachaScreen extends StatefulWidget {
  @override
  _GachaScreenState createState() => _GachaScreenState();
}

class _GachaScreenState extends State<GachaScreen> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  String _drawnCardName = "按下按鈕進行推薦！";
  String _drawnCardImage = "assets/default_card.png"; // 預設圖片
  bool _isDrawing = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // 卡池 (卡片名稱 + 對應圖片)
  final List<Map<String, String>> _gachaPool = [
    {"name": "傳說騎士", "image": "lib/assets/meal_photos/1.jpg"},
    {"name": "火焰法師", "image": "lib/assets/meal_photos/3.jpg"},
    {"name": "神秘忍者", "image": "lib/assets/meal_photos/7.jpg"},
    {"name": "森林精靈", "image": "lib/assets/meal_photos/5.jpg"},
    {"name": "銀色龍", "image": "lib/assets/meal_photos/2.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        int index = _random.nextInt(_gachaPool.length); // 隨機選擇卡片
        _drawnCardName = _gachaPool[index]["name"]!;
        _drawnCardImage = _gachaPool[index]["image"]!;
        _isDrawing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("餐廳推薦"),
        backgroundColor: Colors.purple[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[100]!, Colors.purple[50]!],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "推薦的餐廳:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // 顯示抽到的卡片或卡背
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(_isDrawing ? pi * _animation.value : 0),
                        child: _isDrawing && _animation.value < 0.5
                            ? CardBack()  // 使用獨立的卡背組件
                            : _buildCardFront(),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    _isDrawing ? "思考中..." : _drawnCardName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[700],
                    ),
                  ),
                ],
              ),
            ),
            // 使用獨立的卡匣組件
            CardDeck(
              onDrawCard: _drawCard,
              isDrawing: _isDrawing,
            ),
          ],
        ),
      ),
    );
  }

  // 卡片正面
  Widget _buildCardFront() {
    return Container(
      width: 200,
      height: 300,
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
        border: Border.all(color: Colors.amber[400]!, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          _drawnCardImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}