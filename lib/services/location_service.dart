import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// A service that provides location-related functionality.
///
/// This service handles location permissions, retrieves the current device location,
/// and provides coordinates for named locations.
class LocationService {
  /// Checks and requests location permissions.
  ///
  /// Returns a [Future<bool>] that completes with:
  /// - `true` if permissions are granted
  /// - `false` if permissions are denied or restricted
  ///
  /// Throws an [Exception] if location services are disabled or access is restricted.
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

  /// Gets the current device location.
  ///
  /// Handles permission requests and retrieves the current geographical position.
  ///
  /// Returns a [Future<Position>] containing the device's current location.
  ///
  /// Throws an [Exception] if:
  /// - Location permissions are denied
  /// - Location services are disabled
  /// - Getting the current position fails
  static Future<Position> getCurrentLocation() async {
    // Check and request permissions
    final hasPermission = await _checkAndRequestPermissions();
    if (!hasPermission) {
      throw Exception('Location permissions are required to continue.');
    }

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      throw Exception('Failed to get location: ${e.toString()}');
    }
  }

  /// Gets coordinates for a named location with fallback to current location.
  ///
  /// Provides latitude and longitude for predefined named locations.
  /// If the requested location name is not found, falls back to the device's
  /// current location.
  ///
  /// [locationName] The name of the location to look up
  ///
  /// Returns a [Future<Map<String, double>>] containing 'latitude' and 'longitude' keys.
  ///
  /// Throws an [Exception] if both named location lookup and current location fallback fail.
  /// 
  /// TODO: Replace hardcoded locations with geocoding API in production
  static Future<Map<String, double>> getLocationCoordinates(String locationName) async {
    if (locationName.isEmpty) {
      throw Exception('Location name cannot be empty');
    }
    
    // Hardcoded locations map
    final locationMap = {
      'New Haven': {'latitude': 41.3083, 'longitude': -72.9279},
      'GRA': {'latitude': 6.4489, 'longitude': 3.3892},
      'Trans-Ekulu': {'latitude': 6.4529, 'longitude': 7.5101},
      'Independence Layout': {'latitude': 6.4311, 'longitude': 7.4931},
    };

    // Check for case-insensitive matches
    final normalizedName = locationName.trim().toLowerCase();
    for (final entry in locationMap.entries) {
      if (entry.key.toLowerCase() == normalizedName) {
        return entry.value;
      }
    }

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