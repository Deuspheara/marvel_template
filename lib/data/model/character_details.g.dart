// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDetails _$CharacterDetailsFromJson(Map<String, dynamic> json) =>
    CharacterDetails(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterDetailsToJson(CharacterDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'thumbnail': instance.thumbnail?.toJson(),
    };
