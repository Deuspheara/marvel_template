// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comics _$ComicsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Comics',
      json,
      ($checkedConvert) {
        final val = Comics(
          id: $checkedConvert('id', (v) => v as int?),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          thumbnail: $checkedConvert(
              'thumbnail',
              (v) => v == null
                  ? null
                  : Thumbnail.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ComicsToJson(Comics instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail?.toJson(),
    };
