import 'package:flutter/material.dart';
import './widgets/place_card.dart';
import './widgets/app_bar.dart';
import 'section_details_page.dart';
import 'spot_details_screen.dart';

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
        _buildSection(context, 'Explore'),
        _buildPlaceCards(context),

        // Trending Places section
        _buildSection(context, 'Trending Places'),
        _buildPlaceCards(context),

        // Popular Places section
        _buildSection(context, 'Popular Places'),
        _buildPlaceCards(context),

        // Most Visited section
        _buildSection(context, 'Most Visited'),
        _buildPlaceCards(context),
      ]),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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

  Widget _buildPlaceCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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

            // Convert place data to format expected by SpotDetailsScreen
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