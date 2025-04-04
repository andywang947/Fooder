import 'package:flutter/material.dart';
import 'package:fooder/constants.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({Key? key, 
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.backgroundColor, AppColors.buttonTextColor], // 漸變色
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_rounded),
            label: "吃過的",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "喜歡的",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_copy_outlined),
            label: "想吃的",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.textColor, // 選中的項目顏色
        unselectedItemColor: AppColors.loadingColor, // 未選中的項目顏色
        backgroundColor: Colors.transparent, // 讓背景透明，使用容器背景
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed, // 固定類型
        showSelectedLabels: false,   // ✅ 隱藏選中 label
        showUnselectedLabels: false, // ✅ 隱藏未選中 label
      ),
    );
  }
}
