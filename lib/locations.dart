import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/location_selector.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

/// A screen that displays places organized by geographic location.
///
/// This screen allows users to select a location from a dropdown menu and
/// view places specific to that location across various categories.
class LocationsScreen extends StatefulWidget {
  /// Creates a LocationsScreen.
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

/// The state for the [LocationsScreen] widget.
class _LocationsScreenState extends State<LocationsScreen> {
  /// The currently selected location.
  ///
  /// Default is set to 'New Haven'.
  String _currentLocation = 'New Haven';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          // Location selector dropdown
          LocationSelector(
            onLocationSelected: (location) {
              setState(() {
                _currentLocation = location;
              });
              // Location-specific data fetching would happen here
            },
          ),
          // Main content wrapped in Expanded
          Expanded(
            child: _buildLocationsContent(context),
          ),
        ],
      ),
    );
  }

  /// Builds the main content of the locations screen based on the selected location.
  ///
  /// The content includes a location-specific hero image followed by multiple sections
  /// for different categories (Explore, Bars, Clubs, etc.), each with its own [SectionHeader]
  /// and location-filtered [PlaceCardsList].
  Widget _buildLocationsContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // Location-specific hero image
        SizedBox(
          child: Image.asset(
            'assets/images/locations_hero.png',
            // Dynamic path would be:
            // 'assets/images/locations/${_currentLocation.toLowerCase().replaceAll(' ', '_')}_hero.png',
          ),
        ),
        
        // Explore section (location-specific)
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