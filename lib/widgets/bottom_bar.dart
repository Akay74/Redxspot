import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF080C12),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Hot Alerts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Locations',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color(0xFFB33000),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle:const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
      unselectedLabelStyle:const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      onTap: onItemSelected,
    );
  }
}