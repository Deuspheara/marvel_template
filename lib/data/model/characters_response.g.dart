// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResponse _$CharacterResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CharacterResponse',
      json,
      ($checkedConvert) {
        final val = CharacterResponse(
          offset: $checkedConvert('offset', (v) => v as int?),
          limit: $checkedConvert('limit', (v) => v as int?),
          total: $checkedConvert('total', (v) => v as int?),
          count: $checkedConvert('count', (v) => v as int?),
          results: $checkedConvert('results', (v) => v),
        );
        return val;
      },
    );

Map<String, dynamic> _$CharacterResponseToJson(CharacterResponse instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'limit': instance.limit,
      'total': instance.total,
      'count': instance.count,
      'results': instance.results,
    };
