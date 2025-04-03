import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  final String imagePath;  // 這裡的imagePath可以是本地路徑或URL
  final double width;
  final double height;
  final BoxFit fit;

  const PhotoContainer({
    Key? key,
    required this.imagePath,
    this.width = 200,
    this.height = 200,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 檢查 imagePath 是否為網路圖片
    bool isNetworkImage = imagePath.startsWith('http') || imagePath.startsWith('https');

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // 圓角處理
        child: isNetworkImage
            ? Image.network(
                imagePath, // 網路圖片
                fit: fit,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // 當圖片加載完成時顯示圖片
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ); // 顯示加載進度
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error, color: Colors.red)); // 顯示錯誤圖標
                },
              )
            : Image.asset(
                imagePath,  // 本地圖片
                fit: fit,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error, color: Colors.red)); // 顯示錯誤圖標
                },
              ),
      ),
    );
  }
}
