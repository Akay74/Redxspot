// categories_screen.dart
import 'package:flutter/material.dart';
import 'section_details_page.dart';
import './widgets/place_card.dart';
import './widgets/app_bar.dart';

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
        _buildSection(context, 'Restaurants'),
        _buildPlaceCards(),
        
        // Bars section
        _buildSection(context, 'Bars'),
        _buildPlaceCards(),

        // Clubs section
        _buildSection(context, 'Clubs'),
        _buildPlaceCards(),

        // Gym/Sports section
        _buildSection(context, 'Gym/Sports'),
        _buildPlaceCards(),

        // Hotels section
        _buildSection(context, 'Hotels'),
        _buildPlaceCards(),

        // Malls section
        _buildSection(context, 'Malls'),
        _buildPlaceCards(),
      ]),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
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
          TextButton(
            onPressed: () {
              // Navigate to a new page based on the title
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionDetailsPage(title: title),
                ),
              );
            },
            child: const Text('See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
          )
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
                'image': 'assets/images/gym.png',
                'title': 'Cynthia Garden',
                'location': 'Trans-Ekulu',
                'subtitle': 'Hotel/Gym',
                'rating': '★★★★★',
              },
              {
                'image': 'assets/images/extreme_lounge.png',
                'title': 'Extreme Lounge',
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