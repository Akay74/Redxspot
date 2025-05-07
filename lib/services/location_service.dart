import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  /// Checks and requests location permissions using permission_handler
  static Future<bool> _checkAndRequestPermissions() async {
    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled. Please enable them.');
    }

    // Check permission status using permission_handler
    final status = await Permission.location.status;
    
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Request the permission
      final result = await Permission.location.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // The user opted to never see the permission request dialog again
      await openAppSettings(); // Guide user to app settings
      return false;
    } else if (status.isRestricted) {
      // Restricted (only on iOS)
      throw Exception('Location access is restricted on this device.');
    }
    
    return false;
  }

  /// Gets the current position with proper permission handling
  static Future<Position> getCurrentLocation() async {
    // Check and request permissions
    final hasPermission = await _checkAndRequestPermissions();
    if (!hasPermission) {
      throw Exception('Location permissions are required to continue.');
    }

    // Get the current position
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      throw Exception('Failed to get location: ${e.toString()}');
    }
  }

  /// Gets coordinates for a named location (with fallback to current location)
  static Future<Map<String, double>> getLocationCoordinates(String locationName) async {
    // Hardcoded locations - replace with geocoding API in production
    final locationMap = {
      'New Haven': {'latitude': 41.3083, 'longitude': -72.9279},
      'GRA': {'latitude': 6.4489, 'longitude': 3.3892},
      'Trans-Ekulu': {'latitude': 6.4529, 'longitude': 7.5101},
      'Independence Layout': {'latitude': 6.4311, 'longitude': 7.4931},
    };

    // Return known location if available
    if (locationMap.containsKey(locationName)) {
      return locationMap[locationName]!;
    }

    // Fallback to current location
    try {
      final position = await getCurrentLocation();
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    } catch (e) {
      throw Exception('Could not get location: ${e.toString()}');
    }
  }
}