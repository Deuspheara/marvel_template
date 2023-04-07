import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

import 'character.dart';

part 'character_details.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterDetails {
  int? id;
  String? name;
  String? description;
  Thumbnail? thumbnail;

  CharacterDetails({this.id, this.name, this.description, this.thumbnail});

  factory CharacterDetails.fromJson(Map<String, dynamic> json) =>
      _$CharacterDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDetailsToJson(this);

  //charactersDetails to character
  Character toCharacter() {
    return Character(
      id: id,
      name: name,
      thumbnail: thumbnail,
    );
  }
}
