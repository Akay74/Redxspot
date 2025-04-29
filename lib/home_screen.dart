// home_screen.dart
import 'package:flutter/material.dart';
import './widgets/place_card.dart';
import './widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(children: [
        // hero image
        SizedBox(
          child: Image.asset('assets/images/home_hero.png'),
        ),

        // Explore section
        _buildSection('Explore'),
        _buildPlaceCards(),

        // Trending Places section
        _buildSection('Trending Places'),
        _buildPlaceCards(),

        // Popular Places section
        _buildSection('Popular Places'),
        _buildPlaceCards(),

        // Most Visited section
        _buildSection('Most Visited'),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemBuilder: (context, index) {
            final placeData = [
              {
                'image': 'assets/images/gustavo.png',
                'title': 'Gustavo by cubana',
                'location': 'GRA + 3 others',
                'subtitle': 'Dance club/Lounge',
                'rating': '★★★★★',
              },
              {
                'image': 'assets/images/gustavo.png',
                'title': 'Cynthia Garden',
                'location': 'Trans-Ekulu',
                'subtitle': 'Hotel/Gym',
                'rating': '★★★★★',
              },
              {
                'image': 'assets/images/gustavo.png',
                'title': 'Cynthia Garden',
                'location': 'Independence Layout',
                'subtitle': 'Hotel/Gym',
                'rating': '★★★★★',
              },
            ];
            
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