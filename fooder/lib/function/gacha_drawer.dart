// ignore: unused_import
import 'dart:math';
import 'package:fooder/function/define_restaurant.dart';

// class GachaDrawer {
//   final Random _random = Random();
//   final List<Restaurant> gachaPool;
//   final List<Restaurant> _drawnRestaurants = [];

//   GachaDrawer({required this.gachaPool});

//   Future<Map<String, String>> drawCard() async {
//     if (gachaPool.isEmpty) {
//       return {
//         'name': "無可推薦的餐廳",
//         'image': 'lib/assets/show.jpg',
//       };
//     }

//     // 如果所有餐廳都已抽過，則重置已抽列表
//     if (_drawnRestaurants.length == gachaPool.length) {
//       _drawnRestaurants.clear();
//     }

//     Restaurant selectedRestaurant;
//     do {
//       int index = _random.nextInt(gachaPool.length);
//       selectedRestaurant = gachaPool[index];
//     } while (_drawnRestaurants.contains(selectedRestaurant));

//     _drawnRestaurants.add(selectedRestaurant);

//     return {
//       'name': selectedRestaurant.name,
//       'image': selectedRestaurant.photoUrls.isNotEmpty
//           ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${selectedRestaurant.photoUrls[0]}&key=YOUR_API_KEY'
//           : 'lib/assets/show.jpg',
//     };
//   }
// }

class GachaDrawer {
  final List<Restaurant> gachaPool;
  int _currentIndex = 0;

  GachaDrawer({required this.gachaPool});

  Future<Map<String, String>> drawCard() async {
    if (gachaPool.isEmpty) {
      return {
        'name': "無可推薦的餐廳",
        'image': 'lib/assets/show.jpg',
      };
    }

    // 根據目前 index 抽餐廳
    Restaurant selectedRestaurant = gachaPool[_currentIndex];

    // 更新 index，並做環狀處理
    _currentIndex = (_currentIndex + 1) % gachaPool.length;

    return {
      'name': selectedRestaurant.name,
      'image': selectedRestaurant.photoUrls.isNotEmpty
          ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${selectedRestaurant.photoUrls[0]}&key=YOUR_API_KEY'
          : 'lib/assets/show.jpg',
    };
  }
}