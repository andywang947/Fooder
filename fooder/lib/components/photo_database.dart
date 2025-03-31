import 'package:flutter/material.dart';
import 'photo_list.dart'; // Import the horizontal photo list component

class PhotoDatabase extends StatelessWidget {
  final String title;
  final List<String> imagePaths;

  PhotoDatabase({required this.title, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        HorizontalPhotoList(imagePaths: imagePaths),
        SizedBox(height: 20),
      ],
    );
  }
}
