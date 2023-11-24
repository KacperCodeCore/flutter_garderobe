import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:vector_math/vector_math_64.dart';

class Matrix4Adapter extends TypeAdapter<Matrix4> {
  @override
  final int typeId = 3; // Unikalny typeId

  @override
  Matrix4 read(BinaryReader reader) {
    final data = Float64List(16); // Macierz 4x4

    for (int i = 0; i < 16; i++) {
      data[i] = reader.readDouble();
    }

    return Matrix4.fromFloat64List(data);
  }

  @override
  void write(BinaryWriter writer, Matrix4 obj) {
    final data = obj.storage;

    for (final value in data) {
      writer.writeDouble(value);
    }
  }
}
