import 'package:flutter/material.dart';
import 'package:fooder/function/define_restaurant.dart';
import 'photo_container.dart'; // Import the PhotoContainer component

class FullScreenCard extends StatelessWidget {
  final Restaurant restaurant;

  const FullScreenCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // 確保卡片在畫面中央
        child: Card(
          elevation: 5, // 添加陰影效果
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 讓卡片圓角更滑順
            side: BorderSide(color: Colors.blueAccent, width: 5), // 設定外框
          ),
          child: Container(
            width: MediaQuery.of(context).size.width, // 控制卡片寬度
            height: MediaQuery.of(context).size.height, // 控制卡片高度
            padding: EdgeInsets.all(10), // 內邊距
            child: Column(
              children: [
                // 圖片部分（使用PageView進行圖片切換）
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // 圓角
                    child: PageView.builder(
                      itemCount: restaurant.photoUrls.length, // 使用photoUrls的長度
                      itemBuilder: (context, index) {
                        return PhotoContainer(
                          imagePath: restaurant.photoUrls[index], // 顯示每個URL的圖片
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),

                // 固定顯示的標題區塊（不會滾動）
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 餐廳名稱
                      Text(
                        restaurant.name,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      // 餐廳類型
                      Text(
                        restaurant.types.isNotEmpty ? restaurant.types.first : '',
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),

                // 內容部分 (可滾動)
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 地址
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.red),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  restaurant.formattedAddress,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),

                          // 評分
                          if (restaurant.rating != null)
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                SizedBox(width: 5),
                                Text(
                                  '${restaurant.rating} (${restaurant.userRatingsTotal} reviews)',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          SizedBox(height: 16),

                          // 標籤
                          if (restaurant.types.isNotEmpty)
                            Wrap(
                              spacing: 8,
                              children: restaurant.types.map((type) {
                                return Chip(
                                  label: Text(type),
                                  backgroundColor: Colors.blue[100],
                                );
                              }).toList(),
                            ),
                          SizedBox(height: 12),

                          // 電話號碼
                          if (restaurant.formattedPhoneNumber.isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.green),
                                SizedBox(width: 5),
                                Text(
                                  restaurant.formattedPhoneNumber,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          SizedBox(height: 16),

                          // 營業時間
                          if (restaurant.weekdayText.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hours:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  restaurant.weekdayText.first,
                                  style: TextStyle(fontSize: 16),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Opening Hours'),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: restaurant.weekdayText
                                                .map((day) => Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                      child: Text(day),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text('Close'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text('See all hours'),
                                ),
                              ],
                            ),
                          SizedBox(height: 20), // 增加底部間距，避免滾動到最底部時內容緊貼
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
