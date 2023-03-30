import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class Thumbnail {
  @HiveField(0)
  String? path;

  @HiveField(1)
  String? extension;

  Thumbnail({this.path, this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
