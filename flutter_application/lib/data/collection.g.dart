// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionElementAdapter extends TypeAdapter<CollectionElement> {
  @override
  final int typeId = 1;

  @override
  CollectionElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionElement(
      name: fields[0] as String,
      path: fields[1] as String,
      matrix4: fields[2] as Matrix4,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionElement obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.matrix4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CollectionAdapter extends TypeAdapter<Collection> {
  @override
  final int typeId = 2;

  @override
  Collection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Collection(
      name: fields[0] as String,
      elements: (fields[1] as List).cast<CollectionElement>(),
      lastEdited: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Collection obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.elements)
      ..writeByte(2)
      ..write(obj.lastEdited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
