import 'package:hive/hive.dart';

enum ClotheType {
  none,
  tShirt,
  jeans,
  jacket,
  sneakers,
  hat,
  dress,
  shorts,
}

class ClotheTypeAdapter extends TypeAdapter<ClotheType> {
  @override
  final int typeId = 5; // Unique identifier for the adapter

  @override
  ClotheType read(BinaryReader reader) {
    return ClotheType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, ClotheType obj) {
    writer.writeByte(obj.index);
  }
}
