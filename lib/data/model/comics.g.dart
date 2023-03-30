// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicsAdapter extends TypeAdapter<Comics> {
  @override
  final int typeId = 0;

  @override
  Comics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comics(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Comics obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
