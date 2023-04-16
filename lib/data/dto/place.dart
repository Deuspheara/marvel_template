import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'character_position.dart';

/// This is a simple extension to convert a CharacterPosition to a Place
extension CharacterPositionExtension on CharacterPosition {
  LatLng get location => LatLng(latitude, longitude);

  String? get markerIdVal => null;

  bool get isCluster => false;

  List<ClusterItem> get clusterItems => [];

  int? get clusterId => null;

  Place get place => Place(name: country.toString(), latLng: location);
}

/// This is a simple class to represent a place
class Place with ClusterItem {
  final String name;
  final LatLng latLng;

  Place({required this.name, required this.latLng});

  @override
  LatLng get location => latLng;
}
