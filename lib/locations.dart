import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/location_selector.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

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
            child: _buildLocationsContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsContent(BuildContext context) {
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
        const SectionHeader(title: 'Explore'),
        PlaceCardsList(currentLocation: _currentLocation),
        
        // Bars section
        const SectionHeader(title: 'Bars'),
        PlaceCardsList(currentLocation: _currentLocation),

        // Clubs section
        const SectionHeader(title: 'Clubs'),
        PlaceCardsList(currentLocation: _currentLocation),

        // Gym/Sports section
        const SectionHeader(title: 'Gym/Sports'),
        PlaceCardsList(currentLocation: _currentLocation),

        // Hotels section
        const SectionHeader(title: 'Hotels'),
        PlaceCardsList(currentLocation: _currentLocation),

        // Malls section
        const SectionHeader(title: 'Malls'),
        PlaceCardsList(currentLocation: _currentLocation),
      ]),
    );
  }
}