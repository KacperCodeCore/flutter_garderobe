import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'my_element.dart';

class Boxes {
  static Box<MyElement> getMyElements() => Hive.box<MyElement>('myElementBox');
  static Box<MyElement> getCollection() => Hive.box<MyElement>('collectionBox');
  static Matrix4 m4 = Matrix4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}
