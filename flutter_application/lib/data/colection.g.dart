// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColectionElementAdapter extends TypeAdapter<ColectionElement> {
  @override
  final int typeId = 1;

  @override
  ColectionElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColectionElement(
      name: fields[1] as String,
      path: fields[2] as String,
      matrix4: fields[3] as Matrix4,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, ColectionElement obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.matrix4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColectionElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ColectionAdapter extends TypeAdapter<Colection> {
  @override
  final int typeId = 2;

  @override
  Colection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Colection(
      name: fields[1] as String,
      elements: (fields[2] as List).cast<ColectionElement>(),
      lastEdited: fields[3] as DateTime,
      screenshotPath: fields[4] as String?,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Colection obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.elements)
      ..writeByte(3)
      ..write(obj.lastEdited)
      ..writeByte(4)
      ..write(obj.screenshotPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
