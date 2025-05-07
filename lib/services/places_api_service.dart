import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesApiService {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  static String? _apiKey;
  
  // Initialize the service with your API key
  static Future<void> initialize() async {
    await dotenv.load(); // Load API key from .env file
    _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    if (_apiKey == null) {
      throw Exception('Google Maps API key not found in .env file');
    }
  }

  // Get nearby places of specific type
  static Future<List<Map<String, dynamic>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required String type, // e.g., 'restaurant', 'bar', 'gym'
    double radius = 1500, // 1.5km radius
    int limit = 10,
  }) async {
    if (_apiKey == null) {
      await initialize();
    }

    final url = '$_baseUrl/nearbysearch/json?location=$latitude,$longitude'
        '&radius=$radius&type=$type&key=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final results = List<Map<String, dynamic>>.from(data['results']);
        
        // Format results to match our app's data structure
        final formattedResults = results.take(limit).map((place) {
          // For each place, we'll need to get a photo reference if available
          String photoReference = '';
          if (place['photos'] != null && place['photos'].isNotEmpty) {
            photoReference = place['photos'][0]['photo_reference'];
          }
          
          return {
            'placeId': place['place_id'],
            'title': place['name'],
            'location': place['vicinity'] ?? 'Unknown location',
            'subtitle': _formatTypes(place['types']),
            'rating': _formatRating(place['rating']),
            'photoReference': photoReference,
          };
        }).toList();
        
        return formattedResults;
      } else {
        throw Exception('Failed to load nearby places: ${data['status']}');
      }
    } else {
      throw Exception('Failed to load nearby places: ${response.statusCode}');
    }
  }
  
  // Get details for a specific place
  static Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    if (_apiKey == null) {
      await initialize();
    }

    final url = '$_baseUrl/details/json?place_id=$placeId&fields=name,formatted_address,'
        'formatted_phone_number,rating,website,opening_hours,geometry,photos,types,user_ratings_total,price_level&key=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final result = data['result'];
        
        // Format the details to match our app's requirements
        String photoUrl = '';
        if (result['photos'] != null && result['photos'].isNotEmpty) {
          String photoReference = result['photos'][0]['photo_reference'];
          photoUrl = getPhotoUrl(photoReference);
        }
        
        // Extract establishment year (may not be available, defaulting to recent)
        String established = '2021'; // Default
        
        // Generate short description
        String description = 'A popular ${_formatTypes(result['types'])} located in ${result['vicinity'] ?? 'the area'}';
        
        return {
          'name': result['name'],
          'address': result['formatted_address'] ?? 'Address not available',
          'category': _formatTypes(result['types']),
          'rating': result['rating'] ?? 0,
          'established': established,
          'description': description,
          'photoUrl': photoUrl,
          'phoneNumber': result['formatted_phone_number'],
          'website': result['website'],
          'openingHours': result['opening_hours']?['weekday_text'],
          'priceLevel': result['price_level'],
          'userRatingsTotal': result['user_ratings_total'],
        };
      } else {
        throw Exception('Failed to load place details: ${data['status']}');
      }
    } else {
      throw Exception('Failed to load place details: ${response.statusCode}');
    }
  }
  
  // Get a photo URL from a photo reference
  static String getPhotoUrl(String photoReference, {int maxWidth = 400}) {
    return '$_baseUrl/photo?maxwidth=$maxWidth&photoreference=$photoReference&key=$_apiKey';
  }

  // Helper method to convert Google Place types to a readable category
  static String _formatTypes(List<dynamic> types) {
    if (types.isEmpty) return 'Venue';
    
    // Map common Google Places types to more user-friendly categories
    final typeMap = {
      'restaurant': 'Restaurant',
      'cafe': 'Café',
      'bar': 'Bar',
      'night_club': 'Club',
      'gym': 'Gym',
      'shopping_mall': 'Mall',
      'lodging': 'Hotel',
      'food': 'Food & Dining',
    };
    
    // Find the first recognizable type
    for (var type in types) {
      if (typeMap.containsKey(type)) {
        return typeMap[type]!;
      }
    }
    
    // Default to first type with underscores replaced by spaces and capitalized
    String formattedType = types.first.toString()
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
    
    return formattedType;
  }
  
  // Helper method to format ratings as stars
  static String _formatRating(dynamic rating) {
    if (rating == null) return '★★★☆☆';
    
    double ratingValue = rating is int ? rating.toDouble() : rating;
    int stars = ratingValue.round();
    
    return '★' * stars + '☆' * (5 - stars);
  }
}