import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image picker
import 'photo_container.dart'; // Import the PhotoContainer component

class HorizontalPhotoList extends StatefulWidget {
  final List<String> imagePaths;

  const HorizontalPhotoList({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  @override
  _HorizontalPhotoListState createState() => _HorizontalPhotoListState();
}

class _HorizontalPhotoListState extends State<HorizontalPhotoList> {
  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    photos = List.from(widget.imagePaths); // Copy the initial list
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photos.add(pickedFile.path); // Add the new photo to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0), // Add left & right margin
      child: Column(
        children: [
          SizedBox(
            height: 175, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length + 1, // +1 for the upload button
              itemBuilder: (context, index) {
                if (index < photos.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PhotoContainer(
                      imagePath: photos[index],
                      width: 115,
                      height: 175,
                    ),
                  );
                } else {
                  // Upload Button
                  return GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 115,
                      height: 175,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add_a_photo, size: 40, color: const Color.fromARGB(137, 230, 230, 230)),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
