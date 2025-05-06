// categories_screen.dart
import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildCategoriesContent(context),
    );
  }

  Widget _buildCategoriesContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // hero image
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