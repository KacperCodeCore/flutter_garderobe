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
      x: fields[1] as double,
      y: fields[2] as double,
      rotation: fields[3] as double,
      scale: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionElement obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.x)
      ..writeByte(2)
      ..write(obj.y)
      ..writeByte(3)
      ..write(obj.rotation)
      ..writeByte(4)
      ..write(obj.scale);
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
    );
  }

  @override
  void write(BinaryWriter writer, Collection obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.elements);
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
