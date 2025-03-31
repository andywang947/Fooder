import 'package:flutter/material.dart';
import 'photo_container.dart'; // Import the PhotoContainer component

class FullScreenCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String type;
  final String distance;
  final List<String> tags;
  final String description;

  const FullScreenCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.type,
    required this.distance,
    required this.tags,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container (Fills the top half of the page)
            Expanded(
              flex: 4,
              child: PhotoContainer(
                imagePath: imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Info Section (Bottom half)
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // Type
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    
                    // Distance
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          distance,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    // Special Tags
                    Wrap(
                      spacing: 8,
                      children: tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.blue[100],
                        );
                      }).toList(),
                    ),

                    // description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
