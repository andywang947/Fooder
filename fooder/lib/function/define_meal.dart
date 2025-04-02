import 'dart:convert';

class Meal {
  final int id;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String imageFile;
  final String type;
  final String description;
  final int calorieEstimation;
  final String calorieLevel;
  final List<String> tags;
  final String suggestion;

  Meal({
    required this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.imageFile,
    required this.type,
    required this.description,
    required this.calorieEstimation,
    required this.calorieLevel,
    required this.tags,
    required this.suggestion,
  });

  // Factory constructor to create a Meal instance from a map
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageFile: json['image_file'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      calorieEstimation: json['calorie_estimation'] as int,
      calorieLevel: json['calorie_level'] as String,
      tags: List<String>.from(json['tags'] as List),
      suggestion: json['suggestion'] as String,
    );
  }

  // Method to convert a Meal instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'image_file': imageFile,
      'type': type,
      'description': description,
      'calorie_estimation': calorieEstimation,
      'calorie_level': calorieLevel,
      'tags': tags,
      'suggestion': suggestion,
    };
  }
}

// Function to parse a JSON-encoded list of meals
List<Meal> parseMeals(String jsonString) {
  final List<dynamic> parsed = jsonDecode(jsonString);
  return parsed.map<Meal>((json) => Meal.fromJson(json)).toList();
}
