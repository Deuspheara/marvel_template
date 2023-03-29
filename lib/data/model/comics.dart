import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'comics.g.dart';

@JsonSerializable(
    explicitToJson: true, checked: true, fieldRename: FieldRename.snake)
class Comics {
  int? id;
  String? title;
  String? description;
  Thumbnail? thumbnail;

  Comics({this.id, this.title, this.description, this.thumbnail});

  factory Comics.fromJson(Map<String, dynamic> json) => _$ComicsFromJson(json);

  Map<String, dynamic> toJson() => _$ComicsToJson(this);
}
