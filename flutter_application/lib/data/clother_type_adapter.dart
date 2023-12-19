import 'package:hive/hive.dart';

enum ClotherType {
  none,
  tShirt,
  jeans,
  jacket,
  sneakers,
  hat,
  dress,
  shorts,
}

class ClotherTypeAdapter extends TypeAdapter<ClotherType> {
  @override
  final int typeId = 5; // Unique identifier for the adapter

  @override
  ClotherType read(BinaryReader reader) {
    return ClotherType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, ClotherType obj) {
    writer.writeByte(obj.index);
  }
}
