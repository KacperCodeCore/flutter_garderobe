import 'dart:io';
import 'dart:typed_data';

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
      setState(() {
        collections = Boxes.getCollection().values.toList();
      });
    }
  }

  Future<void> _addElement(String name, String path) async {
    var collectionElement = CollectionElement(
      name: 'new',
      path: path,
      matrix4: Matrix4.identity(),
    );

    setState(() {
      // aktualizacjia kolekcji w Hive, aby zapisac zmiany.
      Boxes.getCollection().getAt(0)!.elements.add(collectionElement);
      // jest to konieczne, aby Hive śledził i zapisywał zmiany.
      Boxes.getCollection().putAt(0, Boxes.getCollection().getAt(0)!);
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
    // print('1 ${Boxes.getCollection().get(0)!.elements[index].name}');
    print(
        'before update ${Boxes.getCollection().get(0)!.elements[index].matrix4}');
    setState(() {
      // aktualizacja elementu w kolekcji w stanie.
      Boxes.getCollection().getAt(0)!.elements[index] = element;
      // print('2 ${element.name}');
      print('during updating ${element.matrix4}');
      // Zapisanie aktualizowany element w Hive.
      //todo update tylko dla elementu nie ckolekcji
      Boxes.getCollection().putAt(0, Boxes.getCollection().getAt(0)!);
    });
    // print('3 ${Boxes.getCollection().get(0)!.elements[index].name}');
    print(
        'after update ${Boxes.getCollection().get(0)!.elements[index].matrix4}');
  }

  /// dodanie nowego elementu do hive
  void _deleteCollectionElement(int index) {
    // var tempElement =
    //     collection.elements.singleWhere((e) => e.id == element.id);

    setState(() {
      Boxes.getCollection().deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('build ${Boxes.getCollection().get(0)!.elements[0].matrix4}');

    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 30,
            bottom: 120,
          ),
          decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Stack(
            children: List.generate(
              collections[0].elements.length,
              (index) => DraggableWidget(
                initMatrix4: collections[0].elements[index].matrix4,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.file(File(elements[0].path)),
                ),
                onDoubleTap: () {},
                onSave: (m4, str) {
                  _updateCollectionElement(
                      'saved', elements[0].path, m4, index);
                  print(str);
                },
              ),
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
                _addElement('test name1', elements[0].path);
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
