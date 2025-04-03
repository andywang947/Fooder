// card_back.dart
import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
  final double width;
  final double height;

  const CardBack({
    Key? key,
    this.width = 250,
    this.height = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.indigo[900],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.indigo[800]!, Colors.indigo[900]!],
        ),
      ),
      child: Stack(
        children: [
          // 卡背紋理
          Positioned.fill(
            child: CustomPaint(
              painter: CardBackPainter(),
            ),
          ),
          // 卡背中心標誌
          Center(
            child: Container(
              width: width * 0.6,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.8),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: width * 0.3,
                ),
              ),
            ),
          ),
          // 卡背邊框
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.amber[400]!,
                  width: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 自定義繪製卡背紋理
class CardBackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // 繪製網格紋理
    for (double i = 0; i < size.width; i += 10) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += 10) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // 繪製四個角落的圓形裝飾
    final cornerPaint = Paint()
      ..color = Colors.amber[600]!
      ..style = PaintingStyle.fill;

    final cornerRadius = size.width * 0.1;
    canvas.drawCircle(Offset(cornerRadius, cornerRadius), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(size.width - cornerRadius, cornerRadius), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(cornerRadius, size.height - cornerRadius), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(size.width - cornerRadius, size.height - cornerRadius), cornerRadius, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}