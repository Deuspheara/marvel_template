import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

///country code
part 'country_code.g.dart'; // Generated code file

@HiveType(typeId: 5) // Hive type ID for the enum
enum CountryCode {
  @HiveField(0)
  fr,
  @HiveField(1)
  es,
  @HiveField(2)
  it,
  @HiveField(3)
  us,
  @HiveField(4)
  ca,
}

//country code with for each list of latlng
extension CountryCodeExtension on CountryCode {
  List<LatLng> get latLngs {
    switch (this) {
      case CountryCode.fr:
        return [
          LatLng(48.8566, 2.3522), // Paris
          LatLng(43.2965, 5.3698), // Marseille
          LatLng(47.2184, -1.5536), // Nantes
          LatLng(48.5734, 7.7521) // Strasbourg
        ];
      case CountryCode.es:
        return [
          LatLng(40.4168, -3.7038), // Madrid
          LatLng(41.3851, 2.1734), // Barcelona
          LatLng(37.3891, -5.9845), // Seville
          LatLng(43.2627, -2.9253), // Bilbao
          LatLng(39.4699, -0.3774), // Valencia
          LatLng(28.1170, -15.4373), // Las Palmas
          LatLng(38.3894, -0.5167), // Alicante
          LatLng(41.6488, -0.8891) // Zaragoza
        ];
      case CountryCode.it:
        return [
          LatLng(41.9028, 12.4964), // Rome
          LatLng(45.4654, 9.1859), // Milan
          LatLng(43.7711, 11.2486), // Florence
          LatLng(40.8518, 14.2681), // Naples
          LatLng(45.4408, 12.3155), // Venice
          LatLng(44.4056, 8.9463), // Genoa
          LatLng(44.4929, 11.3426), // Bologna
          LatLng(45.4384, 10.9916) // Verona
        ];
      case CountryCode.us:
        return [
          LatLng(40.7128, -74.0060), // New York City, NY
          LatLng(37.7749, -122.4194), // San Francisco, CA
          LatLng(41.8781, -87.6298), // Chicago, IL
          LatLng(29.7604, -95.3698), // Houston, TX
          LatLng(34.0522, -118.2437), // Los Angeles, CA
          LatLng(47.6062, -122.3321), // Seattle, WA
          LatLng(42.3601, -71.0589), // Boston, MA
          LatLng(38.9072, -77.0369) // Washington, D.C.
        ];
      case CountryCode.ca:
        return [
          LatLng(45.5017, -73.5673), // Montreal, QC
          LatLng(49.2827, -123.1207), // Vancouver, BC
          LatLng(43.6532, -79.3832), // Toronto, ON
          LatLng(51.0486, -114.0708), // Calgary, AB
          LatLng(53.5444, -113.4909), // Edmonton, AB
          LatLng(45.5231, -73.559), // Laval, QC
          LatLng(49.8951, -97.1384), // Winnipeg
        ];
    }
  }

  LatLng getRandomLatLng() {
    final random = Random();
    final latLngs = this.latLngs;
    return latLngs[random.nextInt(latLngs.length)];
  }
}
