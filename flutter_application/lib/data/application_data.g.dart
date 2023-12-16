// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationDataAdapter extends TypeAdapter<ApplicationData> {
  @override
  final int typeId = 4;

  @override
  ApplicationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApplicationData(
      colectionIndex: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.colectionIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
