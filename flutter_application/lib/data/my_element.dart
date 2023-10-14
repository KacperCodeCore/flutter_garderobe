import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'my_element.g.dart';

@HiveType(typeId: 0, adapterName: 'MyElementAdapter')
class MyElement {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  String name;

  @HiveField(2)
  String path;

  @HiveField(3)
  double height;

  MyElement({
    required this.name,
    required this.path,
    required this.height,
  });
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
