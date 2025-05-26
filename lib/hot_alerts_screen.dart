// hot_alerts_screen.dart
import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

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
        const SectionHeader(title: 'HotSpots'),
        const PlaceCardsList(),
        
        // New Places section
        const SectionHeader(title: 'New Places'),
        const PlaceCardsList(),

        // Spotlight section
        const SectionHeader(title: 'Weekend Spotlight'),
        const PlaceCardsList(),
      ]),
    );
  }
}