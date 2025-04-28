import 'package:flutter/material.dart';
import './widgets/place_card.dart';
import './widgets/app_bar.dart';
import './widgets/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected bottom nav item

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _selectedIndex == 0 
          ? _buildHomeContent() 
          : Center(child: Text('Content for ${_getPageTitle(_selectedIndex)}')),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }

  // Helper method to get page titles
  String _getPageTitle(int index) {
    switch (index) {
      case 0: return 'Home';
      case 1: return 'Hot Alerts';
      case 2: return 'Categories';
      case 3: return 'Locations';
      default: return 'Unknown';
    }
  }

  // Extract the original home content into a separate method
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(children: [
        // hero image
        SizedBox(
          child: Image.asset(
            'assets/images/home_hero.png',
          ),
        ),

        // Explore title
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Text('Explore',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
              )),
            const Text('See all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ))
            ],
          ),
        ),
        // Explore card
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,itemCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (context, index) {
              final placeData = [
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Gustavo by cubana',
                  'location': 'GRA + 3 others',
                  'subtitle': 'Dance club/Lounge',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Trans-Ekulu',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Independence Layout',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
              ];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PlaceCard(
                  image: placeData[index]['image']!,
                  title: placeData[index]['title']!,
                  location: placeData[index]['location']!,
                  subtitle: placeData[index]['subtitle']!,
                  rating: placeData[index]['rating']!,
                ),
              );
            },
            ),
          )
        ),
        // Trending Places Title
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Trending Places',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                )),
              const Text('See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ))
            ],
          ),
        ),
        // Trending Places cards
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,itemCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (context, index) {
              final placeData = [
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Gustavo by cubana',
                  'location': 'GRA + 3 others',
                  'subtitle': 'Dance club/Lounge',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Trans-Ekulu',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Independence Layout',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
              ];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PlaceCard(
                  image: placeData[index]['image']!,
                  title: placeData[index]['title']!,
                  location: placeData[index]['location']!,
                  subtitle: placeData[index]['subtitle']!,
                  rating: placeData[index]['rating']!,
                ),
              );
            },
            ),
          )
        ),
        // Popular Places Title
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Popular Places',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                )),
              const Text('See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ))
            ],
          ),
        ),
        // Popular Places cards
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,itemCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (context, index) {
              final placeData = [
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Gustavo by cubana',
                  'location': 'GRA + 3 others',
                  'subtitle': 'Dance club/Lounge',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Trans-Ekulu',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Independence Layout',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
              ];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PlaceCard(
                  image: placeData[index]['image']!,
                  title: placeData[index]['title']!,
                  location: placeData[index]['location']!,
                  subtitle: placeData[index]['subtitle']!,
                  rating: placeData[index]['rating']!,
                ),
              );
            },
            ),
          )
        ),
        // Most Visited Title
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Most Visited',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                )),
              const Text('See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ))
            ],
          ),
        ),
        // Most Visited cards
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,itemCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (context, index) {
              final placeData = [
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Gustavo by cubana',
                  'location': 'GRA + 3 others',
                  'subtitle': 'Dance club/Lounge',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Trans-Ekulu',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
                {
                  'image': 'assets/images/gustavo.png',
                  'title': 'Cynthia Garden',
                  'location': 'Independence Layout',
                  'subtitle': 'Hotel/Gym',
                  'rating': '★★★★★',
                },
              ];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: PlaceCard(
                  image: placeData[index]['image']!,
                  title: placeData[index]['title']!,
                  location: placeData[index]['location']!,
                  subtitle: placeData[index]['subtitle']!,
                  rating: placeData[index]['rating']!,
                ),
              );
            },
            ),
          )
        ),
      ]),
    );
  }
}