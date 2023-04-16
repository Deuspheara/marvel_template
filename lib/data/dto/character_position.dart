import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'country_code.dart';

part 'character_position.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(
    explicitToJson: true, checked: true, fieldRename: FieldRename.snake)
class CharacterPosition {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  CountryCode? country;

  CharacterPosition(
      {required this.latitude, required this.longitude, this.country});

  factory CharacterPosition.fromJson(Map<String, dynamic> json) =>
      _$CharacterPositionFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterPositionToJson(this);
}
