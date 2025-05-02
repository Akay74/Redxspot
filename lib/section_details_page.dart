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
      body: Center(
        child: Text('Details for $title section'),
      ),
    );
  }
}
