// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_element.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyElementAdapter extends TypeAdapter<MyElement> {
  @override
  final int typeId = 0;

  @override
  MyElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyElement(
      name: fields[1] as String,
      path: fields[2] as String,
    )..key = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, MyElement obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
