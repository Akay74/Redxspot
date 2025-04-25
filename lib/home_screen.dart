import 'package:flutter/material.dart';
import './widgets/place_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF080C12),
        toolbarHeight: 120,
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 42,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: SizedBox(
                height: 26,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search redxspot',
                    prefixIcon: Icon(Icons.search, size: 18),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PlaceCard( // Use the imported widget
                    image: 'assets/images/gustavo.png',
                    title: "Gustavo by cubana",
                    location: "GRA + 3 others",
                    subtitle: "Dance club/Lounge",
                    rating: "★★★★★",
                  ),
                  PlaceCard(
                    image: 'assets/images/gustavo.png',
                    title: "Cynthia Garden",
                    location: "Trans-Ekulu",
                    subtitle: "Hotel/Gym",
                    rating: "★★★★★",
                  ),
                  PlaceCard(
                    image: 'assets/images/gustavo.png',
                    title: "Cynthia Garden",
                    location: "Independence Layout",
                    subtitle: "Hotel/Gym",
                    rating: "★★★★★",
                  ),
                ],
              ),
            )
          ),
          // Trending Places Title
          Padding(
            padding: const EdgeInsets.all(12.0),
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
          Placeholder(
            fallbackHeight: 200,
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
          Placeholder(
            fallbackHeight: 200,
          ),
        ]),
      ),
    );
  }
}