import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';

class SpotDetailsScreen extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SpotDetailsScreen({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: SectionsAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}