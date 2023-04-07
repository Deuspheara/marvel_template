import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

/// Thumbnail: The representation of a thumbnail in the Marvel universe.
@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class Thumbnail {
  /// path: The directory path of to the image.
  @HiveField(0)
  String? path;

  /// extension: The file extension for the image.
  @HiveField(1)
  String? extension;

  /// Thumbnail constructor
  Thumbnail({this.path, this.extension});

  /// Convert json to Thumbnail
  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  /// Convert Thumbnail to json
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
