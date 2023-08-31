import 'package:hive_flutter/hive_flutter.dart';

class ElementDataBase {
  List elementList = [];

  //reference our box
  final _myBox = Hive.box('myBox');

  //run this method if this is th 1st time ever opening this app
  void createInitialData() {
    elementList = [
      ['11111'],
      ['22222'],
    ];
  }

  //load data from database
  void loadData() {
    elementList = _myBox.get('ELEMENTLIST');
  }

  //update the database
  void updateData() {
    _myBox.put('ELEMENTLIST', elementList);
  }
}
