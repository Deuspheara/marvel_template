import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'character.g.dart';

/// Character: The representation of a character in the Marvel universe.
@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class Character {
  /// id: The unique ID of the character resource.
  @HiveField(0)
  int? id;

  /// name: The name of the character.
  @HiveField(1)
  String? name;

  /// resourceURI: The canonical URL identifier for this resource.
  @HiveField(2)
  String? resourceURI;

  /// thumbnail: The representative image for this character.
  @HiveField(3)
  Thumbnail? thumbnail;

  /// Character constructor
  Character({this.id, this.name, this.resourceURI, this.thumbnail});

  /// Convert json to Character
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// Convert Character to json
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
