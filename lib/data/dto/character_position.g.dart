// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_position.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterPositionAdapter extends TypeAdapter<CharacterPosition> {
  @override
  final int typeId = 4;

  @override
  CharacterPosition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterPosition(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      country: fields[2] as CountryCode?,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterPosition obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterPositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterPosition _$CharacterPositionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CharacterPosition',
      json,
      ($checkedConvert) {
        final val = CharacterPosition(
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          country: $checkedConvert(
              'country', (v) => $enumDecodeNullable(_$CountryCodeEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CharacterPositionToJson(CharacterPosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country': _$CountryCodeEnumMap[instance.country],
    };

const _$CountryCodeEnumMap = {
  CountryCode.fr: 'fr',
  CountryCode.es: 'es',
  CountryCode.it: 'it',
  CountryCode.us: 'us',
  CountryCode.ca: 'ca',
};
