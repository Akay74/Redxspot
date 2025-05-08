import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

/// The main home screen of the application.
///
/// This screen presents a variety of content sections including Explore,
/// Trending Places, Popular Places, and Most Visited. Each section displays
/// a list of place cards relevant to that category.
class HomeScreen extends StatelessWidget {
  /// Creates a HomeScreen.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildHomeContent(context),
    );
  }

  /// Builds the main content of the home screen.
  ///
  /// The content includes a hero image at the top followed by several sections,
  /// each with its own [SectionHeader] and [PlaceCardsList]. Each section displays
  /// places filtered by their respective categories.
  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // Hero image
        SizedBox(
          child: Image.asset('assets/images/home_hero.png'),
        ),

        // Explore section
        const SectionHeader(title: 'Explore'),
        const PlaceCardsList(category: 'Explore'),

        // Trending Places section
        const SectionHeader(title: 'Trending Places'),
        const PlaceCardsList(category: 'Trending Places'),

        // Popular Places section
        const SectionHeader(title: 'Popular Places'),
        const PlaceCardsList(category: 'Popular Places'),

        // Most Visited section
        const SectionHeader(title: 'Most Visited'),
        const PlaceCardsList(category: 'Most Visited'),
      ]),
    );
  }
}