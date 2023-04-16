import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

import '../model/character.dart';
import '../model/comics.dart';
import 'character_position.dart';
import 'country_code.dart';

part 'favorite.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(
    explicitToJson: true, checked: true, fieldRename: FieldRename.snake)
class Favorite {
  @HiveField(0)
  Character? character;

  @HiveField(1)
  List<Comics>? comics;

  @HiveField(2)
  CharacterPosition? position;

  Favorite({this.character, this.comics, this.position});

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
