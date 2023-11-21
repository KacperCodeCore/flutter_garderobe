import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/draggable_widget.dart';

import '../../data/boxes.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var collectionElements =
      Boxes.getCollectionElement().values.toList().cast<CollectionElement>();
  var collections = Boxes.getCollection().values.toList().cast<Collection>();

  int _id = 0;
  int get _getID {
    _id += 1;
    return _id;
  }
  List<Widget> _addedWidgets = [];

  @override
  void initState() {
    // Sprawdanie, czy instancja Collection już istnieje w Hive
    if (collections.isEmpty) {
      List<CollectionElement> element = [];
      Collection newCollection = Collection(
          name: 'name', elements: element, lastEdited: DateTime.now());
      final box = Boxes.getCollection();
      box.add(newCollection);
    }
    // utworzenie listy widgetów na podstawie danych z hive
    for (int i = 0; i < collections[0].elements.length; i++) {
      CollectionElement element = collections[0].elements[i];
      _addDraggableWidget(element);
    }
    super.initState();
  }

  /// dodaje DraggableWidget do List<Widget> _addedWidgets = [];
  /// z hive
  void _addDraggableWidget(CollectionElement element) {
    if (_addedWidgets.length > 9) return;

    _addedWidgets.add(
      DraggableWidget(
        initMatrix4: element.matrix4,
        onDoubleTap: () => {},
        onSave: (m4, str) {
          print(str);
          _updateElementInHive(element);
        },
        child: SizedBox(
            width: 100, height: 100, child: Image.file(File(element.path))),
      ),
    );
    // ?-
    print(_addedWidgets.length);
  }

  /// dodanie nowego elementu do hive
  void _addElementToHive(CollectionElement element) {
    if (_addedWidgets.length > 9) return;

    final box = Boxes.getCollection();
    // todo usunąć 0 index
    var collection = box.getAt(0) as Collection;
    collection.elements.add(element);

    _addDraggableWidget(element);
  }

  /// aktualizacja danych elementu w hive
  void _updateElementInHive(CollectionElement element) {
    final box = Boxes.getCollection();
    var collection = box.getAt(0) as Collection;
    int index = collection.elements.indexWhere((e) => e.id == element.id);
    collection.elements[index] = element;
    box.putAt(0, collection); // zaktualizuj kolekcję w bazie danych
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Center(
        ListView.builder(
          itemCount: collections[0].elements.length,
          itemBuilder: itemBuilder,

          
          )
      )),
    );
  }
    
  }
  int _index = 0;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.brown.shade300,
  //     body: Center(
  //       child: ListView(
  //         children: <Widget>[],
  //       )

        
        
  //       (
  //         // index: _index,
  //         // children: [
  //         //   // SizedBox(
  //         //   //     width: MediaQuery.of(context).size.width,
  //         //   //     height: MediaQuery.of(context).size.height,
  //         //   //     child: Container()),
      
  //         //   // Wyświetla wszystkie elementy z kolekcji
  //         //   for (int i = 0; i < _addedWidgets.length; i++) _addedWidgets[i],
  //         //   addwidget
      
          
  //         // ],
  //       ),
  //     ),
  //     floatingActionButton: Padding(
  //       padding: EdgeInsets.only(bottom: 100),
  //       child: FloatingActionButton(
  //         //dodawanie elementu do hve a potem do kolekcji
  //         onPressed: () {
  //           setState(
  //             () {
  //               _addElementToHive(elements[0].path);
  //             },
  //           );
  //         },
  //         child: Icon(Icons.add),
  //       ),
  //     ),
  //   );
  // }

  final List<Widget> _dummyWidgets = [
    //emoji
    Text("🙂", style: TextStyle(fontSize: 120)),
    //heart
    Icon(
      Icons.favorite,
      size: 120,
      color: Colors.red,
    ),
    //text
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Text(
          'Test text ♥️',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    ),
  ];

  @override
  void dispose() {
    for (var widget in _addedWidgets) {
      if (widget is DraggableWidget) {
        widget.dispose();
      }
    }
    super.dispose();
  }
}
