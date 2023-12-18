import 'package:flutter_application/data/application_data.dart';
import 'package:flutter_application/data/colection.dart';
import 'package:hive/hive.dart';
import 'my_element.dart';

class Boxes {
  static Box<MyElement> getMyElements() => Hive.box<MyElement>('myElementBox');
  static Box<ColectionElement> getColectionElement() =>
      Hive.box<ColectionElement>('colectionElementBox');
  static Box<Colection> getColection() => Hive.box<Colection>('colectionBox');
  // static Matrix4 m4 = Matrix4.identity();
  static Box<ApplicationData> getAppData() =>
      Hive.box<ApplicationData>('applicationDataBox');
  static String appDir = '';
}
