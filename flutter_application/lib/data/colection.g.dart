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
      matrix4: fields[1] as Matrix4,
      myElement: fields[2] as MyElement,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, ColectionElement obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.matrix4)
      ..writeByte(2)
      ..write(obj.myElement);
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
    )
      ..id = fields[0] as String
      ..likeIt = fields[5] as bool
      ..comment = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, Colection obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.elements)
      ..writeByte(3)
      ..write(obj.lastEdited)
      ..writeByte(4)
      ..write(obj.screenshotPath)
      ..writeByte(5)
      ..write(obj.likeIt)
      ..writeByte(6)
      ..write(obj.comment);
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
