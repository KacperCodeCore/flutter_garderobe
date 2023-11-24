import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/draggable_widget.dart';

import '../../data/boxes.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var collectionElements =
      Boxes.getCollectionElement().values.toList().cast<CollectionElement>();
  var collections = Boxes.getCollection().values.toList().cast<Collection>();

  @override
  void initState() {
    super.initState();
    if (collections.isEmpty) {
      Collection newCollection = Collection(
        name: 'name',
        elements: [],
        lastEdited: DateTime.now(),
      );
      Boxes.getCollection().add(newCollection);
      setState(() {});
    }
  }

  Future<void> _addCollectionElement(String name, String path) async {
    var collectionElement = CollectionElement(
      name: name,
      path: path,
      matrix4: Matrix4.identity(),
    );
    // final box = Boxes.getCollection();
    // // todo usunąć 0 index
    // var collection = box.getAt(0) as Collection;
    // collection.elements.add(collectionElement);
    // box.add(collection); // Dodanie elementu do Box.
    setState(() {
      Boxes.getCollection().getAt(0)!.elements.add(collectionElement);
    });
  }

  /// dodanie nowego elementu do hive
  void _deleteCollectionElement(CollectionElement element) {
    if (collections.length > 9) return;

    final boxes = Boxes.getCollection();
    // todo usunąć 0 index
    var collection = boxes.getAt(0) as Collection;
    var tempElement =
        collection.elements.singleWhere((e) => e.id == element.id);

    setState(() {
      // usuwanie znaleziony element z kolekcji
      collection.elements.remove(tempElement);

      // aktualizacjia pudełka z kolekcją
      //collectionBox.put(0, collection);
    });
  }

  void _updateCollectionElement(
      String name, String path, Matrix4 m4, int index) {
    CollectionElement element = CollectionElement(
      name: name,
      path: path,
      matrix4: m4,
    );
    // final collection = collections[0];

    // Boxes.getCollection().putAt(0, collection);

    setState(() {
      Boxes.getCollection().getAt(0)!.elements[index] = element;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Center(
        child: Stack(
          children: List.generate(
            collections.length,
            (index) => DraggableWidget(
              child: Image.file(File(elements[0].path)),
              onDoubleTap: () {},
              onSave: (m4, str) {
                // _updateCollectionElement('name', elements[0].path, m4, index);
                print(str);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          //dodawanie elementu do kolekcji
          onPressed: () {
            setState(
              () {
                _addCollectionElement('test name1', elements[0].path);
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}



  // final List<Widget> _dummyWidgets = [
  //   Text("🙂", style: TextStyle(fontSize: 120)),
  //   Icon(
  //     Icons.favorite,
  //     size: 120,
  //     color: Colors.red,
  //   ),
  //   ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: Container(
  //       color: Colors.white,
  //       padding: const EdgeInsets.all(8),
  //       child: Text(
  //         'Test text ♥️',
  //         style: TextStyle(fontSize: 18, color: Colors.black),
  //       ),
  //     ),
  //   ),
  // ];