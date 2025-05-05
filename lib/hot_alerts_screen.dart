// hot_alerts_screen.dart
import 'package:flutter/material.dart';
import 'section_details_page.dart';
import './widgets/place_card.dart';
import './widgets/app_bar.dart';
import 'spot_details_screen.dart';

class HotAlertsScreen extends StatelessWidget {
  const HotAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildHotAlertsContent(context),
    );
  }

  Widget _buildHotAlertsContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // hero image
        SizedBox(
          child: Image.asset('assets/images/hot_alerts_hero.png'),
        ),
        
        // Hotspots section
        _buildSection(context, 'HotSpots'),
        _buildPlaceCards(),
        
        // New Places section
        _buildSection(context, 'New Places'),
        _buildPlaceCards(),

        // Spotlight section
        _buildSection(context, 'Weekend Spotlight'),
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

            final spotData = {
              'name': placeData[index]['title'],
              'address': placeData[index]['location'],
              'category': placeData[index]['subtitle'],
              'rating': 5, // Assuming 5 stars based on the ratings string
              'established': '2021', // Default value
              'description': 'A popular spot in ${placeData[index]['location']}',
              // Using the asset image path for now
              'imageAsset': placeData[index]['image'],
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
                  image: placeData[index]['image']!,
                  title: placeData[index]['title']!,
                  location: placeData[index]['location']!,
                  subtitle: placeData[index]['subtitle']!,
                  rating: placeData[index]['rating']!,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}