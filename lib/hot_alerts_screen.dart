import 'package:flutter/material.dart';
import './widgets/app_bar.dart';
import './widgets/section_header.dart';
import './widgets/place_card_list.dart';

/// A screen that displays current hotspots and special alerts.
///
/// This screen presents sections for HotSpots, New Places, and Weekend Spotlight,
/// highlighting trending and notable locations for users to explore.
class HotAlertsScreen extends StatelessWidget {
  /// Creates a HotAlertsScreen.
  const HotAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildHotAlertsContent(context),
    );
  }

  /// Builds the main content of the hot alerts screen.
  ///
  /// The content includes a hero image at the top, followed by sections
  /// for HotSpots, New Places, and Weekend Spotlight, each with its own
  /// [SectionHeader] and [PlaceCardsList].
  Widget _buildHotAlertsContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // Hero image
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