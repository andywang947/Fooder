import 'dart:convert';

class Restaurant {
  final int id;
  final String name;
  final String formattedAddress;
  final String formattedPhoneNumber;
  final String website;
  final String url;
  final List<String> types;
  final double? rating;
  final int userRatingsTotal;
  final List<String> weekdayText;
  final List<String> photoUrls; // 修改為 List<String>

  Restaurant({
    required this.id,
    required this.name,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.website,
    required this.url,
    required this.types,
    this.rating,
    required this.userRatingsTotal,
    required this.weekdayText,
    required this.photoUrls, // 修改為 List<String>
  });

  // Factory constructor to create a Restaurant instance from a map
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as int,
      name: json['name'] as String,
      formattedAddress: json['formatted_address'] as String,
      formattedPhoneNumber: json['formatted_phone_number'] as String? ?? '',
      website: json['website'] as String? ?? '',
      url: json['url'] as String? ?? '',
      types: List<String>.from(json['types'] as List? ?? []),
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      userRatingsTotal: json['user_ratings_total'] as int? ?? 0,
      weekdayText: List<String>.from(json['weekday_text'] as List? ?? []),
      photoUrls: List<String>.from(json['photo_urls'] as List? ?? []), // 修改為 photo_urls 並使用 List<String>
    );
  }

  // Method to convert a Restaurant instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'formatted_address': formattedAddress,
      'formatted_phone_number': formattedPhoneNumber,
      'website': website,
      'url': url,
      'types': types,
      'rating': rating,
      'user_ratings_total': userRatingsTotal,
      'weekday_text': weekdayText,
      'photo_urls': photoUrls, // 修改為 photo_urls
    };
  }
}

// Function to parse a JSON-encoded list of restaurants
List<Restaurant> parseRestaurants(String jsonString) {
  final List<dynamic> parsed = jsonDecode(jsonString);
  return parsed.map((json) => Restaurant.fromJson(json as Map<String, dynamic>)).toList();
}
