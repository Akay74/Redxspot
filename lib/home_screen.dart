import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
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
        child: Column(
          children: [
            // hero image
            SizedBox(
              child: Image.asset(
                'assets/images/home_hero.png',
              ),
            ),
            
            // Explore cards
            SizedBox(
              child: Row(
                children: [
                  Text('Explore all', {
                    style: TextStyle(
                      fontSize: 
                    )
                  })
                ],
              ),
            ),
            // Trending Places cards
            Placeholder(
              fallbackHeight: 200,
            ),
            // Popular Places cards
            Placeholder(
              fallbackHeight: 200,
            ),
          ]
        ),
      ),
    );
  }
}