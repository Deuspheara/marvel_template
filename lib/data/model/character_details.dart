import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

import 'character.dart';

part 'character_details.g.dart';

/// CharacterDetails: The representation of a character in the Marvel universe.
@JsonSerializable(explicitToJson: true)
class CharacterDetails {
  /// id: The unique ID of the character resource.
  int? id;

  /// name: The name of the character.
  String? name;

  /// description: A description of the character.
  String? description;

  /// thumbnail: The representative image for this character.
  Thumbnail? thumbnail;

  /// CharacterDetails constructor
  CharacterDetails({this.id, this.name, this.description, this.thumbnail});

  /// Convert json to CharacterDetails
  factory CharacterDetails.fromJson(Map<String, dynamic> json) =>
      _$CharacterDetailsFromJson(json);

  /// Convert CharacterDetails to json
  Map<String, dynamic> toJson() => _$CharacterDetailsToJson(this);

  /// Convert CharacterDetails to Character
  Character toCharacter() {
    return Character(
      id: id,
      name: name,
      thumbnail: thumbnail,
    );
  }
}
