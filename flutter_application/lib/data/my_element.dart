import 'package:hive/hive.dart';

part 'my_element.g.dart';

@HiveType(typeId: 0, adapterName: 'MyElementAdapter')
class MyElement {
  MyElement({
    required this.name,
    required this.path,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String path;
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
