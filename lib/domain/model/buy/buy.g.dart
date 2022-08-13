// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyAdapter extends TypeAdapter<Buy> {
  @override
  final int typeId = 3;

  @override
  Buy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Buy(
      name: fields[0] as String,
      storeID: fields[1] as int,
      typeID: fields[2] as int,
      currencyID: fields[3] as int,
      discount: fields[4] as double,
      price: fields[5] as double,
      date: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Buy obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.storeID)
      ..writeByte(2)
      ..write(obj.typeID)
      ..writeByte(3)
      ..write(obj.currencyID)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
