import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'my_element.dart';

part 'collection.g.dart';

@HiveType(typeId: 1, adapterName: 'CollectionElementAdapter')
class CollectionElement {
  @HiveField(0)
  String id = Uuid().v4();

  @HiveField(1)
  Matrix4 matrix4;

  @HiveField(2)
  MyElement myElement;

  CollectionElement({
    required this.matrix4,
    required this.myElement,
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
  String? screenshotPath;

  @HiveField(5)
  bool likeIt = false;

  @HiveField(6)
  String comment = '';

  Collection({
    required this.name,
    required this.elements,
    required this.lastEdited,
    this.screenshotPath,
  });
}
