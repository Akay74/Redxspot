// widgets/place_cards_list_widget.dart
import 'package:flutter/material.dart';
import './place_card.dart';
import '../spot_details_screen.dart';

class PlaceCardsList extends StatelessWidget {
  final List<Map<String, dynamic>>? placeDataList;
  final String? currentLocation;

  const PlaceCardsList({
    super.key,
    this.placeDataList,
    this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    // Default data if none provided
    final List<Map<String, dynamic>> places = placeDataList ?? [
      {
        'image': 'assets/images/gustavo.png',
        'title': 'Gustavo by cubana',
        'location': currentLocation ?? 'GRA + 3 others',
        'subtitle': 'Dance club/Lounge',
        'rating': '★★★★★',
      },
      {
        'image': 'assets/images/gym.png',
        'title': 'Cynthia Garden',
        'location': currentLocation ?? 'Trans-Ekulu',
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
      },
      {
        'image': 'assets/images/extreme_lounge.png',
        'title': 'Extreme Lounge',
        'location': currentLocation ?? 'Independence Layout',
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: places.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemBuilder: (context, index) {
            final spotData = {
              'name': places[index]['title'],
              'address': places[index]['location'],
              'category': places[index]['subtitle'],
              'rating': 5, // Assuming 5 stars based on the ratings string
              'established': '2021', // Default value
              'description': 'A popular spot in ${places[index]['location']}',
              // Using the asset image path for now
              'imageAsset': places[index]['image'],
            };
            
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotDetailsScreen(
                        spotData: spotData,
                      ),
                    ),
                  );
                },
                child: PlaceCard(
                  image: places[index]['image']!,
                  title: places[index]['title']!,
                  location: places[index]['location']!,
                  subtitle: places[index]['subtitle']!,
                  rating: places[index]['rating']!,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}