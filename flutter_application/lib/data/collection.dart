import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../pages/collection/draggable_widget.dart';

part 'collection.g.dart';
// part 'auto_generated.g.dart';

@HiveType(typeId: 1, adapterName: 'CollectionElementAdapter')
class CollectionElement {
  @HiveField(0)
  String name;

  @HiveField(1)
  double x;

  @HiveField(2)
  double y;

  @HiveField(3)
  double rotation;

  @HiveField(4)
  double scale;

  CollectionElement(
      {required this.name,
      required this.x,
      required this.y,
      required this.rotation,
      required this.scale});
}

@HiveType(typeId: 2, adapterName: 'CollectionAdapter')
class Collection {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<CollectionElement> elements;

  Collection({required this.name, required this.elements});
}
