import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';
import '../widgets/sections_header.dart';
import '../widgets/sections_grid_items.dart';

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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SectionHeader(
              title: title,
              subtitle: displaySubtitle,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75, // Increased card size
                    ),
                    itemCount: displayItems.length,
                    itemBuilder: (context, index) {
                      final item = displayItems[index];
                      return GestureDetector(
                        child: SectionGridItem(
                          image: item['image']!,
                          title: item['title']!,
                          location: item['location']!,
                          subtitle: item['subtitle']!,
                          rating: item['rating']!,
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

  void _showPlaceholder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: const Text('This feature is under development'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}