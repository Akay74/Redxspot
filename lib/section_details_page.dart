import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';
import '../widgets/sections_header.dart';
import '../widgets/sections_grid_items.dart';
import 'spot_details_screen.dart';

/// A page that displays all items within a specific section or category.
///
/// This page shows a grid of places belonging to a particular category or section,
/// allowing users to browse through them and navigate to detailed views.
class SectionDetailsPage extends StatelessWidget {
  /// The title of the section.
  final String title;
  
  /// An optional subtitle for the section.
  final String? subtitle;
  
  /// An optional list of items to display in the section.
  ///
  /// Each item is a map containing details such as image path, title,
  /// location, subtitle, and rating.
  final List<Map<String, String>>? items;
  
  /// Creates a SectionDetailsPage.
  ///
  /// The [title] parameter is required.
  /// If [subtitle] is not provided, a default subtitle of "Explore [title] locations" is used.
  /// If [items] is not provided, a default list of items is generated based on the [title].
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
                        'rating': 5, // Default 5 stars
                        'established': '2021', // Default value
                        'description': 'A popular ${item['subtitle']} located in ${item['location']}',
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
  
  /// Generates a default list of items based on the section title.
  ///
  /// This is used when no explicit items are provided in the constructor.
  /// Returns a list of maps, each representing a place with its details.
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