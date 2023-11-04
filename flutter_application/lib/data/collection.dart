import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'collection.g.dart';
// part 'auto_generated.g.dart';

@HiveType(typeId: 1, adapterName: 'CollectionElementAdapter')
class CollectionElement {
  @HiveField(0)
  String name;

  @HiveField(1)
  String path;

  @HiveField(2)
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
  String name;

  @HiveField(1)
  List<CollectionElement> elements;

  Collection({required this.name, required this.elements});
}
