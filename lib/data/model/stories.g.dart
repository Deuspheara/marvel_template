// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stories _$StoriesFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Stories',
      json,
      ($checkedConvert) {
        final val = Stories(
          id: $checkedConvert('id', (v) => v as int?),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          resourceURI: $checkedConvert('resource_u_r_i', (v) => v as String?),
          thumbnail: $checkedConvert(
              'thumbnail',
              (v) => v == null
                  ? null
                  : Thumbnail.fromJson(v as Map<String, dynamic>)),
          type: $checkedConvert('type', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'resourceURI': 'resource_u_r_i'},
    );

Map<String, dynamic> _$StoriesToJson(Stories instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'resource_u_r_i': instance.resourceURI,
      'thumbnail': instance.thumbnail?.toJson(),
      'type': instance.type,
    };
