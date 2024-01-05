import 'package:flutter/material.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'my_element.dart';

part 'colection.g.dart';

@HiveType(typeId: 1, adapterName: 'ColectionElementAdapter')
class ColectionElement {
  @HiveField(0)
  String id = Uuid().v4();

  // @HiveField(1)
  // String name;

  @HiveField(1)
  Matrix4 matrix4;

  @HiveField(2)
  MyElement myElement;

  // @HiveField(2)
  // String path;

  // @HiveField(4)
  // double height;

  // @HiveField(5)
  // double width;

  // @HiveField(6)
  // ClotherType type;

  ColectionElement({
    // required this.name,
    // required this.path,
    required this.matrix4,
    required this.myElement,
    // required this.height,
    // required this.width,
    // required this.type,
  });
}

@HiveType(typeId: 2, adapterName: 'ColectionAdapter')
class Colection {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  String name;

  @HiveField(2)
  List<ColectionElement> elements;

  @HiveField(3)
  DateTime lastEdited;

  @HiveField(4)
  String? screenshotPath;

  @HiveField(5)
  bool likeIt = false;

  @HiveField(6)
  String comment = '';

  Colection({
    required this.name,
    required this.elements,
    required this.lastEdited,
    this.screenshotPath,
  });
}
