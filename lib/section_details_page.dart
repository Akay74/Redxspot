import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';
import '../widgets/sections_header.dart';
import '../widgets/place_card.dart';

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
    return Scaffold(
      appBar: SectionsAppBar(),

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
        'image': 'assets/images/extreme_lounge.png',
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
        'image': 'assets/images/extreme_lounge.png',
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