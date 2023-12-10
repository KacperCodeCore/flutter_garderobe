import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'application_data.g.dart';

@HiveType(typeId: 4, adapterName: 'ApplicationDataAdapter')
class ApplicationData {
  @HiveField(0)
  int collectionIndex;

  ApplicationData({this.collectionIndex = 0});
}
