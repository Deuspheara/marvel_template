import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'character.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class Character {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? resourceURI;

  @HiveField(3)
  Thumbnail? thumbnail;

  Character({this.id, this.name, this.resourceURI, this.thumbnail});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
