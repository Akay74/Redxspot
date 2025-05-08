import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A service that interacts with the Google Places API.
///
/// Provides functionality to search for nearby places, retrieve place details,
/// and access place photos using the Google Places API.
class PlacesApiService {
  /// Base URL for the Google Places API
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  
  /// Google Maps API key loaded from environment variables
  static String? _apiKey;
  
  /// Initializes the service with the Google Maps API key from environment variables.
  ///
  /// Loads the API key from the .env file using flutter_dotenv.
  /// Won't reload if already initialized.
  ///
  /// Throws an [Exception] if the API key is not found in the .env file
  /// or if the .env file cannot be loaded.
  static Future<void> initialize() async {
    if (_apiKey != null) return; // Already initialized
    
    try {
      await dotenv.load();
      _apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
      if (_apiKey == null || _apiKey!.isEmpty) {
        throw Exception('Google Maps API key not found in .env file');
      }
    } catch (e) {
      throw Exception('Failed to initialize Places API: ${e.toString()}');
    }
  }

  /// Retrieves nearby places of a specific type.
  ///
  /// [latitude] The latitude coordinate for the search center.
  /// [longitude] The longitude coordinate for the search center.
  /// [type] The type of place to search for (e.g., 'restaurant', 'bar', 'gym').
  /// [radius] The search radius in meters (defaults to 1500).
  /// [limit] The maximum number of results to return (defaults to 10).
  ///
  /// Returns a [Future<List<Map<String, dynamic>>>] containing the formatted places data.
  ///
  /// Throws an [Exception] if the API request fails or returns an error status.
  static Future<List<Map<String, dynamic>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required String type,
    double radius = 1500,
    int limit = 10,
  }) async {
    if (_apiKey == null) {
      await initialize();
    }

    try {
      final url = '$_baseUrl/nearbysearch/json?location=$latitude,$longitude'
          '&radius=$radius&type=$type&key=$_apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final List<dynamic> rawResults = data['results'] ?? [];
          
          final formattedResults = rawResults.take(limit).map((place) {
            if (place is! Map<String, dynamic>) {
              return null; // Skip invalid results
            }
            
            String photoReference = '';
            final photos = place['photos'];
            if (photos is List && photos.isNotEmpty && photos[0] is Map) {
              photoReference = photos[0]['photo_reference']?.toString() ?? '';
            }
            
            return {
              'placeId': place['place_id']?.toString() ?? '',
              'title': place['name']?.toString() ?? 'Unnamed Place',
              'location': place['vicinity']?.toString() ?? 'Unknown location',
              'subtitle': _formatTypes(place['types'] is List ? place['types'] : []),
              'rating': _formatRating(place['rating']),
              'photoReference': photoReference,
            };
          }).whereType<Map<String, dynamic>>().toList();
          
          return formattedResults;
        } else {
          throw Exception('Failed to load nearby places: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load nearby places: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error retrieving nearby places: ${e.toString()}');
    }
  }
  
  /// Retrieves detailed information about a specific place.
  ///
  /// [placeId] The Google Places API place_id of the desired place.
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the formatted place details.
  ///
  /// Throws an [Exception] if the API request fails or returns an error status.
  static Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    if (_apiKey == null) {
      await initialize();
    }

    if (placeId.isEmpty) {
      throw Exception('Place ID cannot be empty');
    }

    try {
      final url = '$_baseUrl/details/json?place_id=$placeId&fields=name,formatted_address,'
          'vicinity,formatted_phone_number,rating,website,opening_hours,geometry,photos,types,user_ratings_total,price_level&key=$_apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final Map<String, dynamic> result = data['result'] ?? {};
          
          String photoUrl = '';
          final photos = result['photos'];
          if (photos is List && photos.isNotEmpty && photos[0] is Map) {
            final photoReference = photos[0]['photo_reference']?.toString() ?? '';
            if (photoReference.isNotEmpty) {
              photoUrl = getPhotoUrl(photoReference);
            }
          }
          
          // Default establishment year if not available
          const String established = '2021';
          
          // Extract types safely
          final List<dynamic> types = result['types'] is List ? result['types'] : [];
          
          // Generate short description with fallbacks
          final String vicinity = result['vicinity']?.toString() ?? '';
          final String address = result['formatted_address']?.toString() ?? '';
          final String location = vicinity.isNotEmpty ? vicinity : (address.isNotEmpty ? address : 'the area');
          final String description = 'A popular ${_formatTypes(types)} located in $location';
          
          return {
            'name': result['name']?.toString() ?? 'Unnamed Place',
            'address': result['formatted_address']?.toString() ?? 'Address not available',
            'category': _formatTypes(types),
            'rating': result['rating'] ?? 0,
            'established': established,
            'description': description,
            'photoUrl': photoUrl,
            'phoneNumber': result['formatted_phone_number']?.toString(),
            'website': result['website']?.toString(),
            'openingHours': result['opening_hours'] is Map ? 
                result['opening_hours']['weekday_text'] : null,
            'priceLevel': result['price_level'],
            'userRatingsTotal': result['user_ratings_total'],
          };
        } else {
          throw Exception('Failed to load place details: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error retrieving place details: ${e.toString()}');
    }
  }
  
  /// Generates a URL for retrieving a place photo from the Google Places API.
  ///
  /// [photoReference] The photo_reference string from the Places API.
  /// [maxWidth] The maximum width of the photo to retrieve (defaults to 400).
  ///
  /// Returns a [String] containing the URL to fetch the photo.
  /// 
  /// Throws an [Exception] if the API is not initialized or if the photoReference is empty.
  static String getPhotoUrl(String photoReference, {int maxWidth = 400}) {
    if (_apiKey == null) {
      throw Exception('Places API not initialized. Call initialize() first.');
    }
    
    if (photoReference.isEmpty) {
      throw Exception('Photo reference cannot be empty');
    }
    
    return '$_baseUrl/photo?maxwidth=$maxWidth&photoreference=$photoReference&key=$_apiKey';
  }

  /// Converts Google Places API type identifiers to user-friendly category names.
  ///
  /// [types] A list of type identifiers from the Places API.
  ///
  /// Returns a [String] with a formatted and user-friendly category name.
  static String _formatTypes(List<dynamic> types) {
    if (types.isEmpty) return 'Venue';
    
    final typeMap = {
      'restaurant': 'Restaurant',
      'cafe': 'Café',
      'bar': 'Bar',
      'night_club': 'Club',
      'gym': 'Gym',
      'shopping_mall': 'Mall',
      'lodging': 'Hotel',
      'food': 'Food & Dining',
      'establishment': 'Establishment',
      'store': 'Store',
      'point_of_interest': 'Point of Interest',
    };
    
    for (var type in types) {
      if (type is String && typeMap.containsKey(type)) {
        return typeMap[type]!;
      }
    }
    
    // Safe handling for first type
    if (types.isNotEmpty && types.first is String) {
      // Format first type if no matching type is found
      String formattedType = types.first.toString()
          .replaceAll('_', ' ')
          .split(' ')
          .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
          .join(' ');
      
      return formattedType;
    }
    
    return 'Venue'; // Default fallback
  }
  
  /// Formats a numerical rating as a star display string.
  ///
  /// [rating] A numerical rating value (null, int, or double).
  ///
  /// Returns a [String] representing the rating as filled and empty stars (e.g. "★★★☆☆").
  static String _formatRating(dynamic rating) {
    if (rating == null) return '★★★☆☆';
    
    double ratingValue;
    
    try {
      if (rating is int) {
        ratingValue = rating.toDouble();
      } else if (rating is double) {
        ratingValue = rating;
      } else if (rating is String) {
        ratingValue = double.tryParse(rating) ?? 3.0;
      } else {
        return '★★★☆☆'; // Default for unknown types
      }
      
      // Ensure the rating is within bounds
      int stars = ratingValue.round().clamp(0, 5);
      return '★' * stars + '☆' * (5 - stars);
    } catch (e) {
      return '★★★☆☆'; // Default for any parsing errors
    }
  }
}