import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'stories.g.dart';

/// Stories: The representation of a stories in the Marvel universe.
@JsonSerializable(
    explicitToJson: true, checked: true, fieldRename: FieldRename.snake)
class Stories {
  /// id: The unique ID of the stories resource.
  int? id;

  /// title: The canonical title of the stories.
  String? title;

  /// description: A description of the stories.
  String? description;

  /// resourceURI: The canonical URL identifier for this resource.
  String? resourceURI;

  /// thumbnail: The representative image for this stories.
  Thumbnail? thumbnail;

  /// type: The type of the story (interior or cover).
  String? type;

  /// Stories constructor
  Stories(
      {this.id,
      this.title,
      this.description,
      this.resourceURI,
      this.thumbnail,
      this.type});

  /// Convert json to Stories
  factory Stories.fromJson(Map<String, dynamic> json) =>
      _$StoriesFromJson(json);

  /// Convert Stories to json
  Map<String, dynamic> toJson() => _$StoriesToJson(this);
}
