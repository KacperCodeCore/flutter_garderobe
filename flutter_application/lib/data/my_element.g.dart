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
      id: fields[0] as String,
      name: fields[1] as String,
      path: fields[2] as String,
      height: fields[3] as double,
      width: fields[4] as double,
      type: fields[5] as ClotheType,
      shelfIndex: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MyElement obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.width)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.shelfIndex);
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
