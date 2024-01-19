import 'package:flutter_application/data/application_data.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:hive/hive.dart';
import 'my_element.dart';

class Boxes {
  static Box<MyElement> getMyElements() => Hive.box<MyElement>('myElementBox');
  static Box<CollectionElement> getCollectionElement() =>
      Hive.box<CollectionElement>('collectionElementBox');
  static Box<Collection> getCollection() =>
      Hive.box<Collection>('collectionBox');
  static Box<ApplicationData> getAppData() =>
      Hive.box<ApplicationData>('appDataBox');

  static String appDir = '';
}
