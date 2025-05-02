import 'package:flutter/material.dart';
import './widgets/sections_app_bar.dart';

class SectionDetailsPage extends StatelessWidget {
  final String title;

  const SectionDetailsPage({super.key, required this.title});

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
