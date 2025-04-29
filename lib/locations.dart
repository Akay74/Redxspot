import 'package:flutter/material.dart';
import './widgets/place_card.dart';
import './widgets/app_bar.dart';
import './widgets/location_selector.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  String _currentLocation = 'New Haven'; // Track selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          // Add the LocationSelector at the top
          LocationSelector(
            onLocationSelected: (location) {
              setState(() {
                _currentLocation = location;
              });
              // You could add location-specific data fetching here
            },
          ),
          // Your existing content (now wrapped in Expanded)
          Expanded(
            child: _buildLocationsContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsContent() {
    return SingleChildScrollView(
      child: Column(children: [
        // hero image (now shows location-specific image)
        SizedBox(
          child: Image.asset(
            'assets/images/locations_hero.png',
            // 'assets/images/locations/${_currentLocation.toLowerCase().replaceAll(' ', '_')}_hero.png',
          ),
        ),
        
        // Restaurants section (now shows location-specific places)
        _buildSection('Explore'),
        _buildPlaceCards(),
        
        // Bars section
        _buildSection('Bars'),
        _buildPlaceCards(),

        // Clubs section
        _buildSection('Clubs'),
        _buildPlaceCards(),

        // Gym/Sports section
        _buildSection('Gym/Sports'),
        _buildPlaceCards(),

        // Hotels section
        _buildSection('Hotels'),
        _buildPlaceCards(),

        // Malls section
        _buildSection('Malls'),
        _buildPlaceCards(),
      ]),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
              )),
          const Text('See all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  Widget _buildPlaceCards() {
    final placeData = [
      {
        'image': 'assets/images/gustavo.png',
        'title': 'Gustavo by cubana',
        'location': _currentLocation,
        'subtitle': 'Dance club/Lounge',
        'rating': '★★★★★',
      },
      {
        'image': 'assets/images/gym.png',
        'title': 'Cynthia Garden',
        'location': _currentLocation,
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
      },
      {
        'image': 'assets/images/extreme_lounge.png',
        'title': 'Extreme Lounge',
        'location': _currentLocation,
        'subtitle': 'Lounge/Bar',
        'rating': '★★★★★',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: placeData.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: PlaceCard(
                image: placeData[index]['image']!,
                title: placeData[index]['title']!,
                location: placeData[index]['location']!,
                subtitle: placeData[index]['subtitle']!,
                rating: placeData[index]['rating']!,
              ),
            );
          },
        ),
      ),
    );
  }
}