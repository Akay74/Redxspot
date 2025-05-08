import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

/// A screen that displays content organized by categories.
///
/// This screen shows various places organized into different categories
/// such as Restaurants, Bars, Clubs, Gym/Sports, Hotels, and Malls.
/// Each category is represented with a section header and a list of places.
class CategoriesScreen extends StatelessWidget {
  /// Creates a CategoriesScreen.
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildCategoriesContent(context),
    );
  }

  /// Builds the main content of the categories screen.
  ///
  /// The content includes a hero image at the top, followed by
  /// multiple sections for different categories, each with its own
  /// [SectionHeader] and [PlaceCardsList].
  Widget _buildCategoriesContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // Hero image
        SizedBox(
          child: Image.asset('assets/images/categories_hero.png'),
        ),
        
        // Restaurants section
        const SectionHeader(title: 'Restaurants'),
        const PlaceCardsList(),
        
        // Bars section
        const SectionHeader(title: 'Bars'),
        const PlaceCardsList(),

        // Clubs section
        const SectionHeader(title: 'Clubs'),
        const PlaceCardsList(),

        // Gym/Sports section
        const SectionHeader(title: 'Gym/Sports'),
        const PlaceCardsList(),

        // Hotels section
        const SectionHeader(title: 'Hotels'),
        const PlaceCardsList(),

        // Malls section
        const SectionHeader(title: 'Malls'),
        const PlaceCardsList(),
      ]),
    );
  }
}