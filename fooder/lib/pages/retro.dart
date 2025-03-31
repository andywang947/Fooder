import 'package:flutter/material.dart';
import '../components/photo_database.dart'; // Import the component

class Retro extends StatelessWidget {

  final List<String> imagePaths1 = [
    'lib/assets/photos/1.jpg',
    'lib/assets/photos/2.jpg',
    'lib/assets/photos/3.jpg',
  ];

  final List<String> imagePaths2 = [
    'lib/assets/photos/4.jpg',
    'lib/assets/photos/5.jpg',
    'lib/assets/photos/6.jpg',
    'lib/assets/photos/7.jpg',
  ];

  final List<String> imagePaths3 = [
    'lib/assets/photos/8.jpg',
    'lib/assets/photos/9.jpg',
    'lib/assets/photos/10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            PhotoDatabase(imagePaths: imagePaths3, title: '2025 3/30 - Now',),
            PhotoDatabase(imagePaths: imagePaths2, title: '2025 3/23 - 3/29',),
            PhotoDatabase(imagePaths: imagePaths1, title: '2025 3/16 - 3/22',),
          ],
        ),
      ),
    );
  }
}
