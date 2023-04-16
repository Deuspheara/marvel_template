// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final int typeId = 3;

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      character: fields[0] as Character?,
      comics: (fields[1] as List?)?.cast<Comics>(),
      position: fields[2] as CharacterPosition?,
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.character)
      ..writeByte(1)
      ..write(obj.comics)
      ..writeByte(2)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Favorite',
      json,
      ($checkedConvert) {
        final val = Favorite(
          character: $checkedConvert(
              'character',
              (v) => v == null
                  ? null
                  : Character.fromJson(v as Map<String, dynamic>)),
          comics: $checkedConvert(
              'comics',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Comics.fromJson(e as Map<String, dynamic>))
                  .toList()),
          position: $checkedConvert(
              'position',
              (v) => v == null
                  ? null
                  : CharacterPosition.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'character': instance.character?.toJson(),
      'comics': instance.comics?.map((e) => e.toJson()).toList(),
      'position': instance.position?.toJson(),
    };
