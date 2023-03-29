import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'stories.g.dart';

@JsonSerializable(
    explicitToJson: true, checked: true, fieldRename: FieldRename.snake)
class Stories {
  int? id;
  String? title;
  String? description;
  String? resourceURI;
  Thumbnail? thumbnail;
  String? type;

  Stories(
      {this.id,
      this.title,
      this.description,
      this.resourceURI,
      this.thumbnail,
      this.type});

  factory Stories.fromJson(Map<String, dynamic> json) =>
      _$StoriesFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesToJson(this);
}
