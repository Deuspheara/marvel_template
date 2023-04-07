import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'comics.g.dart';

/// Comics: The representation of a comics in the Marvel universe.
@HiveType(typeId: 0)
@JsonSerializable(
    explicitToJson: true, checked: true, fieldRename: FieldRename.snake)
class Comics {
  /// id: The unique ID of the comics resource.
  @HiveField(0)
  int? id;

  /// title: The canonical title of the comics.
  @HiveField(1)
  String? title;

  /// description: A description of the comics.
  @HiveField(2)
  String? description;

  /// thumbnail: The representative image for this comics.
  Thumbnail? thumbnail;

  /// Comics constructor
  Comics({this.id, this.title, this.description, this.thumbnail});

  /// Convert json to Comics
  factory Comics.fromJson(Map<String, dynamic> json) => _$ComicsFromJson(json);

  /// Convert Comics to json
  Map<String, dynamic> toJson() => _$ComicsToJson(this);
}
