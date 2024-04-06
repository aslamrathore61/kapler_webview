// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NativeItemAdapter extends TypeAdapter<NativeItem> {
  @override
  final int typeId = 0;

  @override
  NativeItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NativeItem(
      items: (fields[0] as List?)?.cast<Items>(),
    );
  }

  @override
  void write(BinaryWriter writer, NativeItem obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NativeItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemsAdapter extends TypeAdapter<Items> {
  @override
  final int typeId = 1;

  @override
  Items read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Items(
      title: fields[0] as String?,
      icon: fields[1] as String?,
      uRL: fields[2] as String?,
      id: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Items obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.uRL)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
