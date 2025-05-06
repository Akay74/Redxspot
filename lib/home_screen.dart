import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildHomeContent(context),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // hero image
        SizedBox(
          child: Image.asset('assets/images/home_hero.png'),
        ),

        // Explore section
        const SectionHeader(title: 'Explore'),
        const PlaceCardsList(),

        // Trending Places section
        const SectionHeader(title: 'Trending Places'),
        const PlaceCardsList(),

        // Popular Places section
        const SectionHeader(title: 'Popular Places'),
        const PlaceCardsList(),

        // Most Visited section
        const SectionHeader(title: 'Most Visited'),
        const PlaceCardsList(),
      ]),
    );
  }
}