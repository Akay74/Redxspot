import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A screen that displays detailed information about a specific place or spot.
///
/// This screen shows comprehensive information about a place including its image,
/// name, address, category, rating, description, contact information, opening hours,
/// and provides action buttons for directions and calling.
class SpotDetailsScreen extends StatelessWidget {
  /// The data of the spot to display.
  ///
  /// This map should contain various details about the spot such as:
  /// - name: The name of the spot
  /// - address: The physical address
  /// - category: The type of establishment
  /// - rating: A numerical rating (typically 1-5)
  /// - established: The year established
  /// - description: A text description
  /// - imageAsset: The path to an asset image (optional if photoUrl is provided)
  /// - photoUrl: A URL to an image (optional)
  /// - phoneNumber: Contact phone number (optional)
  /// - website: The website URL (optional)
  /// - openingHours: List of opening hours strings (optional)
  /// - priceLevel: Price level as an integer (optional)
  /// - userRatingsTotal: Total number of user ratings (optional)
  final Map<String, dynamic> spotData;

  /// Creates a SpotDetailsScreen.
  ///
  /// The [spotData] parameter must not be null.
  const SpotDetailsScreen({
    super.key,
    required this.spotData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with image
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                spotData['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
              background: spotData.containsKey('photoUrl') && spotData['photoUrl'] != null && spotData['photoUrl'].isNotEmpty
                  ? Image.network(
                      spotData['photoUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/gustavo.png',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      spotData.containsKey('imageAsset') && spotData['imageAsset'] != null
                          ? spotData['imageAsset']
                          : 'assets/images/gustavo.png',
                      fit: BoxFit.cover,
                    ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to favorites')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share functionality coming soon')),
                  );
                },
              ),
            ],
          ),
          
          // Details content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic info section
                  _buildInfoSection(context),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    spotData['description'] ?? 'No description available',
                    style: const TextStyle(fontSize: 16),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Contact info and website
                  if (spotData.containsKey('phoneNumber') && spotData['phoneNumber'] != null)
                    _buildContactInfo(),
                  
                  const SizedBox(height: 24),
                  
                  // Opening hours
                  if (spotData.containsKey('openingHours') && spotData['openingHours'] != null)
                    _buildOpeningHours(),
                  
                  const SizedBox(height: 32),
                  
                  // Actions buttons
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the information section card with address, rating, category, and establishment year.
  ///
  /// This section provides an overview of the key details of the spot.
  Widget _buildInfoSection(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spotData['address'] ?? 'Address not available',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          ' ${spotData['rating']?.toString() ?? 'N/A'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    if (spotData.containsKey('userRatingsTotal') && spotData['userRatingsTotal'] != null)
                      Text(
                        '(${spotData['userRatingsTotal']} reviews)',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      spotData['category'] ?? 'Not specified',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Established',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      spotData['established'] ?? 'Unknown',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            if (spotData.containsKey('priceLevel') && spotData['priceLevel'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    const Text(
                      'Price Level: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '\$' * (spotData['priceLevel'] as int),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the contact information section with phone number and website.
  ///
  /// This section is only displayed if phone number or website information is available.
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (spotData['phoneNumber'] != null)
          GestureDetector(
            onTap: () => _launchUrl('tel:${spotData['phoneNumber']}'),
            child: Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 8),
                Text(
                  spotData['phoneNumber'],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        if (spotData['website'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () => _launchUrl(spotData['website']),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      spotData['website'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the opening hours section showing the business hours.
  ///
  /// This section is only displayed if opening hours information is available.
  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Opening Hours',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            (spotData['openingHours'] as List).length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                spotData['openingHours'][index],
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the action buttons for directions and calling.
  ///
  /// These buttons allow users to quickly navigate to the location or contact the business.
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.directions),
          label: const Text('Directions'),
          onPressed: () {
            _launchDirections();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.call),
          label: const Text('Call'),
          onPressed: spotData['phoneNumber'] != null
              ? () => _launchUrl('tel:${spotData['phoneNumber']}')
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Launches a URL in the device's browser or appropriate app.
  ///
  /// [urlString] is the URL to be launched.
  void _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  /// Launches Google Maps with directions to the spot's address.
  void _launchDirections() async {
    final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(spotData['address'])}';
    _launchUrl(googleMapsUrl);
  }
}