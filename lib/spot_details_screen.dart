import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';

class SpotDetailsScreen extends StatefulWidget {
  const SpotDetailsScreen({
    super.key,
  });

  @override
  State<SpotDetailsScreen> createState() => _SpotDetailsScreenState();
}

class _SpotDetailsScreenState extends State<SpotDetailsScreen> {
  bool _showAllReviews = false;
  bool _isLoadingReviews = false;

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Brendan Briocs',
      'date': '01/11/2022',
      'rating': 5,
      'title': 'Great Lounge',
      'comment':
          'To furnish you with promotion free surveys, we really do gather a little commission from deals of the items we audit on our site. Fray, we NEVER consider these commissions while looking into items.',
    },
    {
      'name': 'Brendan Briocs',
      'date': '01/11/2022',
      'rating': 5,
      'title': 'Great Lounge',
      'comment':
          'To furnish you with promotion free surveys, we really do gather a little commission from deals of the items we audit on our site. Fray, we NEVER consider these commissions while looking into items.',
    },
    {
      'name': 'Jane Smith',
      'date': '05/12/2022',
      'rating': 4,
      'title': 'Nice Atmosphere',
      'comment':
          'Really enjoyed the music and drinks. The staff was very friendly and helpful.',
    },
    {
      'name': 'Michael Johnson',
      'date': '15/01/2023',
      'rating': 5,
      'title': 'Amazing Experience',
      'comment':
          'One of the best lounges I\'ve visited in Enugu. Great ambiance and excellent service.',
    },
  ];


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