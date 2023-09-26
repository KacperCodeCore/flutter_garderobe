import 'package:hive/hive.dart';
import 'my_element.dart';

class Boxes {
  static Box<MyElement> getMyElements() => Hive.box<MyElement>('myElementBox');
}
