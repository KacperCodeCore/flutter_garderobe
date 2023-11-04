import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:hive/hive.dart';
import 'my_element.dart';

class Boxes {
  static Box<MyElement> getMyElements() => Hive.box<MyElement>('myElementBox');
  static Box<CollectionElement> getCollectionElement() =>
      Hive.box<CollectionElement>('collectionElementBox');
  static Matrix4 m4 = Matrix4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}
