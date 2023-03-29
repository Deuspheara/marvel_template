import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/character.dart';

part 'characters_response.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class CharacterResponse {
  int? offset;
  int? limit;
  int? total;
  int? count;
  dynamic results;

  CharacterResponse(
      {this.offset, this.limit, this.total, this.count, this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResponseToJson(this);
}
