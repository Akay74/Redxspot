// widgets/place_cards_list_widget.dart
import 'package:flutter/material.dart';
import './place_card.dart';
import '../spot_details_screen.dart';
import '../services/places_api_service.dart';
import '../services/location_service.dart';

class PlaceCardsList extends StatefulWidget {
  final String? category;
  final String? currentLocation;

  const PlaceCardsList({
    super.key,
    this.category,
    this.currentLocation,
  });

  @override
  State<PlaceCardsList> createState() => _PlaceCardsListState();
}

class _PlaceCardsListState extends State<PlaceCardsList> {
  late Future<List<Map<String, dynamic>>> _placesFuture;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  @override
  void didUpdateWidget(PlaceCardsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload places if location or category changes
    if (oldWidget.currentLocation != widget.currentLocation || 
        oldWidget.category != widget.category) {
      _loadPlaces();
    }
  }

  Future<void> _loadPlaces() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Determine the location to search
      Map<String, double> coordinates;
      if (widget.currentLocation != null) {
        coordinates = await LocationService.getLocationCoordinates(widget.currentLocation!);
      } else {
        final position = await LocationService.getCurrentLocation();
        coordinates = {
          'latitude': position.latitude,
          'longitude': position.longitude
        };
      }

      // Determine the place type to search for
      String placeType = 'restaurant'; // default
      if (widget.category != null) {
        // Map our app's categories to Google Places API types
        final typeMap = {
          'Restaurants': 'restaurant',
          'Bars': 'bar',
          'Clubs': 'night_club',
          'Gym/Sports': 'gym',
          'Hotels': 'lodging',
          'Malls': 'shopping_mall',
          'Explore': 'point_of_interest',
          'HotSpots': 'point_of_interest',
          'New Places': 'point_of_interest',
          'Weekend Spotlight': 'point_of_interest',
          'Trending Places': 'point_of_interest',
          'Popular Places': 'point_of_interest',
          'Most Visited': 'point_of_interest',
        };
        placeType = typeMap[widget.category] ?? placeType;
      }

      // Fetch places from the API
      _placesFuture = PlacesApiService.getNearbyPlaces(
        latitude: coordinates['latitude']!,
        longitude: coordinates['longitude']!,
        type: placeType,
        limit: 5, // Limit to 5 places for performance
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load places: ${e.toString()}';
        });
      }
      // Use default data as fallback
      _placesFuture = Future.value(_getDefaultPlaces());
    }
  }

  List<Map<String, dynamic>> _getDefaultPlaces() {
    // Fallback data in case API fails
    return [
      {
        'placeId': 'default_1',
        'title': 'Gustavo by cubana',
        'location': widget.currentLocation ?? 'GRA + 3 others',
        'subtitle': 'Dance club/Lounge',
        'rating': '★★★★★',
        'photoReference': '',
      },
      {
        'placeId': 'default_2',
        'title': 'Cynthia Garden',
        'location': widget.currentLocation ?? 'Trans-Ekulu',
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
        'photoReference': '',
      },
      {
        'placeId': 'default_3',
        'title': 'Extreme Lounge',
        'location': widget.currentLocation ?? 'Independence Layout',
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
        'photoReference': '',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 170,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return SizedBox(
        height: 170,
        child: Center(child: Text(_errorMessage)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: SizedBox(
        height: 170,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _placesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No places found'));
            }

            final places = snapshot.data!;
            
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (context, index) {
                final place = places[index];
                
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      _navigateToSpotDetails(context, place['placeId']);
                    },
                    child: PlaceCard(
                      image: place['photoReference'].isNotEmpty ? 
                        PlacesApiService.getPhotoUrl(place['photoReference']) : 
                        'assets/images/gustavo.png', // Fallback image
                      title: place['title'],
                      location: place['location'],
                      subtitle: place['subtitle'],
                      rating: place['rating'],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _navigateToSpotDetails(BuildContext context, String placeId) {
    // Show loading indicator immediately (before any async operations)
    final loadingDialog = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    
    // Initiate the async operations
    _fetchPlaceDetailsAndNavigate(context, placeId, loadingDialog);
  }
  
  // Separate method to handle async operations
  Future<void> _fetchPlaceDetailsAndNavigate(
    BuildContext context, 
    String placeId,
    Future<dynamic> loadingDialog
  ) async {
    try {
      // Fetch detailed information about the selected place
      final spotData = await PlacesApiService.getPlaceDetails(placeId);
      
      // Check if the widget is still in the tree before using context
      if (!mounted) return;
      
      // Close the loading indicator
      Navigator.of(context).pop();
      
      // Navigate to the details screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SpotDetailsScreen(
            spotData: spotData,
          ),
        ),
      );
    } catch (e) {
      // Check if the widget is still in the tree before using context
      if (!mounted) return;
      
      // Close the loading indicator
      Navigator.of(context).pop();
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load place details: ${e.toString()}')),
      );
    }
  }
}