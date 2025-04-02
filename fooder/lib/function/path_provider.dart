import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // Added missing import

class LocalPhotoList extends StatefulWidget {
  const LocalPhotoList({Key? key}) : super(key: key);

  @override
  _LocalPhotoListState createState() => _LocalPhotoListState();
}

class _LocalPhotoListState extends State<LocalPhotoList> {
  List<File> imageFiles = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dir = Directory('${directory.path}/images');
      
      if (await dir.exists()) {
        List<File> files = dir
            .listSync()
            .whereType<File>()
            .where((file) => 
                file.path.toLowerCase().endsWith('.jpg') || 
                file.path.toLowerCase().endsWith('.jpeg') || 
                file.path.toLowerCase().endsWith('.png'))
            .toList();
        
        if (mounted) {
          setState(() {
            imageFiles = files;
            isLoading = false;
          });
        }
      } else {
        // Create the directory if it doesn't exist
        await dir.create(recursive: true);
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Error loading images: $e";
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (imageFiles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "No images found",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      );
    }

    return SizedBox(
      height: 120, // Fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageFiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                imageFiles[index],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}