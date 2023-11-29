import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'collection.g.dart';

@HiveType(typeId: 1, adapterName: 'CollectionElementAdapter')
class CollectionElement {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  String name;

  @HiveField(2)
  String path;

  @HiveField(3)
  Matrix4 matrix4;

  CollectionElement({
    required this.name,
    required this.path,
    required this.matrix4,
  });
}

@HiveType(typeId: 2, adapterName: 'CollectionAdapter')
class Collection {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  String name;

  @HiveField(2)
  List<CollectionElement> elements;

  @HiveField(3)
  DateTime lastEdited;

  @HiveField(4)
  String screenshotPath;

  Collection({
    required this.name,
    required this.elements,
    required this.lastEdited,
    required this.screenshotPath,
  });
}
