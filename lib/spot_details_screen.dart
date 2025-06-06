import 'package:flutter/material.dart';
import '../widgets/sections_app_bar.dart';
import '../widgets/place_card.dart';
import 'section_details_page.dart';

class SpotDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> spotData;

  const SpotDetailsScreen({
    super.key,
    required this.spotData,
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

  final List<Map<String, dynamic>> _placeData = [
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
    // Determine how many reviews to show
    final reviewsToShow = _showAllReviews ? _reviews : _reviews.take(2).toList();

    return Scaffold(
      appBar: SectionsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Location overlay
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.spotData['name'] ?? 'Spot Name',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.spotData['address'] ?? 'Address not available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            // Hero Image
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // Handle both remote URLs and asset images
                  image: widget.spotData['imageUrl'] != null
                      ? NetworkImage(widget.spotData['imageUrl'])
                      : widget.spotData['imageAsset'] != null
                          ? AssetImage(widget.spotData['imageAsset']) as ImageProvider
                          : const AssetImage('assets/images/spot_details_hero.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Directions button
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Directions'),
              ),
            ),
            const SizedBox(height: 10),
            // Category, Rating and Established
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.spotData['category'] ?? 'Club/Lounge',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // Star Rating
                  Row(
                    children: List.generate(
                      widget.spotData['rating'] ?? 5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Established
                  Text(
                    'Established ${widget.spotData['established'] ?? '2021'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    widget.spotData['description'] ?? 
                    'Platinum Lounge is a newly established cozy nightclub in Enugu. It is one of the attractions in the Platinum Event Centre, a major galleria in Enugu.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            // Reviews Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reviews Header
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Reviews List
                  ...reviewsToShow.map((review) => _buildReviewCard(context, review)),
                  
                  // Loading indicator or See more button
                  if (_isLoadingReviews)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (!_showAllReviews)
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _loadMoreReviews,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('See more'),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // You may also like section
            _buildSection(context, 'You may also like'),
            _buildPlaceCards(context),

            const SizedBox(height: 16),
            
            // People also visit section
            _buildSection(context, 'People also visit'),
            _buildPlaceCards(context),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
              )),
          TextButton(
            onPressed: () {
              // Navigate to a new page based on the title
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionDetailsPage(title: title),
                ),
              );
            },
            child: const Text('See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
          )
        ],
      ),
    );
  }

  Widget _buildPlaceCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _placeData.length,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemBuilder: (context, index) {
            // Convert place data to format expected by SpotDetailsScreen
            final spotData = {
              'name': _placeData[index]['title'],
              'address': _placeData[index]['location'],
              'category': _placeData[index]['subtitle'],
              'rating': 5, // Assuming 5 stars based on the ratings string
              'established': '2021', // Default value
              'description': 'A popular spot in ${_placeData[index]['location']}',
              'imageAsset': _placeData[index]['image'],
            };

            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotDetailsScreen(
                        spotData: spotData,
                      ),
                    ),
                  );
                },
                child: PlaceCard(
                  image: _placeData[index]['image']!,
                  title: _placeData[index]['title']!,
                  location: _placeData[index]['location']!,
                  subtitle: _placeData[index]['subtitle']!,
                  rating: _placeData[index]['rating']!,
                ),
              ),
            );
          },
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
                radius: 16,
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
                            fontSize: 13,
                          ),
                    ),
                    // Stars
                    Row(
                      children: List.generate(
                        review['rating'],
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 11,
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
                      fontSize: 13,
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }
}