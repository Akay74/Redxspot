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

  Future<void> _loadMoreReviews() async {
    setState(() {
      _isLoadingReviews = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _showAllReviews = true;
      _isLoadingReviews = false;
    });
  }

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

  Widget _buildReviewCard(BuildContext context, Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer info row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              
              // Name and date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    // Stars
                    Row(
                      children: List.generate(
                        review['rating'],
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Date
              Text(
                review['date'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Review title
          Text(
            review['title'],
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 4),
          
          // Review content
          Text(
            review['comment'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}