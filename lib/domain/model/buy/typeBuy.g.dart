// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typeBuy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeBuyAdapter extends TypeAdapter<TypeBuy> {
  @override
  final int typeId = 1;

  @override
  TypeBuy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeBuy(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TypeBuy obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeBuyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
