import 'package:hive/hive.dart';
import 'my_element.dart';

class Boxes {
  static Box<MyElement> getMyElements() => Hive.box<MyElement>('myElementBox');
  static Box<MyElement> getMyCollection() =>
      Hive.box<MyElement>('myElementBox');
}
