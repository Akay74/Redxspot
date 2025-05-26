import 'package:flutter/material.dart';
import '../section_details_page.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
              )),
          TextButton(
            onPressed: onSeeAllPressed ?? () {
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
}