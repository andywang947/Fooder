import 'package:flutter/material.dart';
import 'package:fooder/function/define_restaurant.dart';
import 'photo_container.dart'; // Import the PhotoContainer component
import 'package:fooder/constants.dart';

class FullScreenCard extends StatelessWidget {
  final Restaurant restaurant;

  const FullScreenCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // 設定背景顏色
      body: Center(
        child: Card(
          color: AppColors.cardBackground, // 設定卡片背景顏色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓整個 Column 內元素靠左
              children: [
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    child: PageView.builder(
                      itemCount: restaurant.photoUrls.length,
                      itemBuilder: (context, index) {
                        return PhotoContainer(
                          imagePath: restaurant.photoUrls[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        textAlign: TextAlign.left, // 文字靠左對齊
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor, // 設定標題顏色
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        restaurant.distance_text.trim().isEmpty || restaurant.duration_text.trim().isEmpty
                            ? ' 1.0 公里，走路約 14 分鐘' // '未有距離標示'
                            : ' ${restaurant.distance_text}，走路約 ${restaurant.duration_text}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: AppColors.locationColor),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  restaurant.formattedAddress,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          if (restaurant.rating != null)
                            Row(
                              children: [
                                Icon(Icons.star, color: AppColors.ratingColor),
                                SizedBox(width: 5),
                                Text(
                                  '${restaurant.rating}   ( ${restaurant.userRatingsTotal} 則評論 )',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 16),
                          if (restaurant.types.isNotEmpty)
                            Wrap(
                              spacing: 8,
                              children: restaurant.types.map((type) {
                                return Chip(
                                  label: Text(
                                    type,
                                    style: TextStyle(color: AppColors.chipTextColor, fontFamily: 'GenSenRounded'),
                                  ),
                                  backgroundColor: AppColors.chipBackgroundColor,
                                );
                              }).toList(),
                            ),
                          SizedBox(height: 12),
                          if (restaurant.formattedPhoneNumber.isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.phoneColor),
                                SizedBox(width: 5),
                                Text(
                                  restaurant.formattedPhoneNumber,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 16),
                          if (restaurant.weekdayText.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '營業時間：',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                Text(
                                  restaurant.weekdayText.first,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.secondaryTextColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: AppColors.dialogBackgroundColor,
                                        title: Text(
                                          '營業時間',
                                          style: TextStyle(color: AppColors.textColor),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: restaurant.weekdayText
                                                .map((day) => Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                      child: Text(
                                                        day,
                                                        style: TextStyle(color: AppColors.textColor),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text(
                                              '關閉',
                                              style: TextStyle(color: AppColors.buttonTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '查看詳細',
                                    style: TextStyle(color: AppColors.linkTextColor),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}