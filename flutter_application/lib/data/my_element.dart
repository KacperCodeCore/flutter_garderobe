import 'package:hive/hive.dart';

import 'clothe_type_adapter.dart';

part 'my_element.g.dart';

@HiveType(typeId: 0, adapterName: 'MyElementAdapter')
class MyElement {
  @HiveField(0)
  String id;
  // String? id = Uuid().v4();

  @HiveField(1)
  String name;

  @HiveField(2)
  String path;

  @HiveField(3)
  double height;

  @HiveField(4)
  double width;

  @HiveField(5)
  ClotheType type;

  @HiveField(6)
  int? shelfIndex;

  MyElement({
    required this.id,
    required this.name,
    required this.path,
    required this.height,
    required this.width,
    required this.type,
    required this.shelfIndex,
  });

  MyElement.copy(MyElement other)
      : id = other.id,
        name = other.name,
        path = other.path,
        height = other.height,
        width = other.width,
        type = other.type,
        shelfIndex = other.shelfIndex;
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
