import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String subtitle;
  final String rating;

  const PlaceCard({
    required this.image,
    required this.title,
    required this.location,
    required this.subtitle,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 90,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
          // Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
              Text(location, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              Text(rating, style: TextStyle(color: Colors.orange)),
            ],
          ),
        ],
      ),
    );
  }
}
