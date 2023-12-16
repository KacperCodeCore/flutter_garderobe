import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'colection.g.dart';

@HiveType(typeId: 1, adapterName: 'CollectionElementAdapter')
class ColectionElement {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  String name;

  @HiveField(2)
  String path;

  @HiveField(3)
  Matrix4 matrix4;

  ColectionElement({
    required this.name,
    required this.path,
    required this.matrix4,
  });
}

@HiveType(typeId: 2, adapterName: 'CollectionAdapter')
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
  String screenshotPath;

  Colection({
    required this.name,
    required this.elements,
    required this.lastEdited,
    required this.screenshotPath,
  });
}