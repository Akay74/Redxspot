import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  final Function(String) onLocationSelected;
  
  const LocationSelector({super.key, required this.onLocationSelected});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String _selectedLocation = 'New Haven'; // Default selected location

  final List<String> _locations = [
    'New Haven',
    'Ind.Layout',
    'Trans-Ekulu',
    'Uwani',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          final location = _locations[index];
          final isSelected = location == _selectedLocation;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedLocation = location;
              });
              widget.onLocationSelected(location);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.red : Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}