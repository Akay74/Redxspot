import 'package:flutter/material.dart';

class SectionDetailsPage extends StatelessWidget {
  final String title;

  const SectionDetailsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title section'),
      ),
    );
  }
}