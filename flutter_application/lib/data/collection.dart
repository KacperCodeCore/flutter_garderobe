import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../pages/collection/draggable_widget.dart';

part 'collection.g.dart';
// part 'auto_generated.g.dart';

@HiveType(typeId: 1, adapterName: 'CollectionAdapter')
class Collection {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<DraggableWidget> widgets;

  Collection({required this.name, required this.widgets});
}
