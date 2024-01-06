import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'my_element.dart';

part 'colection.g.dart';

@HiveType(typeId: 1, adapterName: 'ColectionElementAdapter')
class ColectionElement {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  Matrix4 matrix4;

  @HiveField(2)
  MyElement myElement;

  ColectionElement({
    required this.matrix4,
    required this.myElement,
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
