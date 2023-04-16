// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryCodeAdapter extends TypeAdapter<CountryCode> {
  @override
  final int typeId = 5;

  @override
  CountryCode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CountryCode.fr;
      case 1:
        return CountryCode.es;
      case 2:
        return CountryCode.it;
      case 3:
        return CountryCode.us;
      case 4:
        return CountryCode.ca;
      default:
        return CountryCode.fr;
    }
  }

  @override
  void write(BinaryWriter writer, CountryCode obj) {
    switch (obj) {
      case CountryCode.fr:
        writer.writeByte(0);
        break;
      case CountryCode.es:
        writer.writeByte(1);
        break;
      case CountryCode.it:
        writer.writeByte(2);
        break;
      case CountryCode.us:
        writer.writeByte(3);
        break;
      case CountryCode.ca:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
