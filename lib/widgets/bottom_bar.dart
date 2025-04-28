import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundColor;
  final double iconSize;

  // Image paths for each tab (active and inactive states)
  final Map<int, Map<String, String>> tabIcons = {
    0: {
      'active': 'assets/icons/home_active.png',
      'inactive': 'assets/icons/home.png',
    },
    1: {
      'active': 'assets/icons/hot_alerts_active.png',
      'inactive': 'assets/icons/hot_alerts.png',
    },
    2: {
      'active': 'assets/icons/categories_active.png',
      'inactive': 'assets/icons/categories.png',
    },
    3: {
      'active': 'assets/icons/locations_active.png',
      'inactive': 'assets/icons/locations.png',
    },
  };

  CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.selectedColor = const Color(0xFFB33000),
    this.unselectedColor = Colors.grey,
    this.backgroundColor = const Color(0xFF080C12),
    this.iconSize = 24.0,
  }) : super(key: key);

  Widget _buildTabIcon(int index) {
    final isSelected = selectedIndex == index;
    final iconPath = isSelected 
        ? tabIcons[index]!['active']! 
        : tabIcons[index]!['inactive']!;

    return Image.asset(
      iconPath,
      width: iconSize,
      height: iconSize,
      color: isSelected ? selectedColor : unselectedColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor,
      items: [
        BottomNavigationBarItem(
          icon: _buildTabIcon(0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildTabIcon(1),
          label: 'Hot Alerts',
        ),
        BottomNavigationBarItem(
          icon: _buildTabIcon(2),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: _buildTabIcon(3),
          label: 'Locations',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      onTap: onItemSelected,
    );
  }
}