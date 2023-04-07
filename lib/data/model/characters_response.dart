import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/character.dart';

part 'characters_response.g.dart';

/// CharacterResponse: The representation of a character in the Marvel universe.
@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class CharacterResponse {
  /// offset: The requested offset (number of skipped results) of the call.
  int? offset;

  /// limit: The requested result limit.
  int? limit;

  /// total: The total number of resources available given the current filter set.
  int? total;

  /// count: The total number of results returned by this call.
  int? count;

  /// results: The list of characters returned by the call.
  dynamic results;

  /// CharacterResponse constructor
  CharacterResponse(
      {this.offset, this.limit, this.total, this.count, this.results});

  /// Convert json to CharacterResponse
  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseFromJson(json);

  /// Convert CharacterResponse to json
  Map<String, dynamic> toJson() => _$CharacterResponseToJson(this);
}
