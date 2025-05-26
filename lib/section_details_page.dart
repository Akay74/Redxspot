import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';
import '../widgets/sections_header.dart';
import '../widgets/sections_grid_items.dart';
import 'spot_details_screen.dart';

class SectionDetailsPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Map<String, String>>? items;
  
  const SectionDetailsPage({
    super.key,
    required this.title,
    this.subtitle,
    this.items,
  });
  
  @override
  Widget build(BuildContext context) {
    final displayItems = items ?? _generateDefaultItems(title);
    final displaySubtitle = subtitle ?? 'Explore $title locations';
    
    return Scaffold(
      appBar: SectionsAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: title,
              subtitle: displaySubtitle,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 570),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.70,
                    ),
                    itemCount: displayItems.length,
                    itemBuilder: (context, index) {
                      final item = displayItems[index];
                      
                      // Convert item data to format expected by SpotDetailsScreen
                      final spotData = {
                        'name': item['title'],
                        'address': item['location'],
                        'category': item['subtitle'],
                        'rating': 5, // Assuming 5 stars based on the rating string
                        'established': '2021', // Default value
                        'description': 'A popular ${item['subtitle']} located in ${item['location']}',
                        // Using the asset image path for now
                        'imageAsset': item['image'],
                      };
                      
                      return GestureDetector(
                        child: SectionGridItem(
                          image: item['image']!,
                          title: item['title']!,
                          location: item['location']!,
                          subtitle: item['subtitle']!,
                          rating: item['rating']!,
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
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Map<String, String>> _generateDefaultItems(String category) {
    return [
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
        'image': 'assets/images/gustavo.png',
        'title': 'Extreme Lounge',
        'location': 'Independence Layout',
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
      },
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
        'image': 'assets/images/gym.png',
        'title': 'Extreme Lounge',
        'location': 'Independence Layout',
        'subtitle': 'Hotel/Gym',
        'rating': '★★★★★',
      },
    ];
  }
}