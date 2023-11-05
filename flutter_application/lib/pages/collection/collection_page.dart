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

  List<Widget> _addedWidgets = [];

  @override
  void initState() {
    // Sprawdanie, czy instancja Collection już istnieje w Hive
    // tymczasowe
    if (collections.isEmpty) {
      List<CollectionElement> element = [];
      Collection newCollection = Collection(
          name: 'name', elements: element, lastEdited: DateTime.now());
      final box = Boxes.getCollection();
      box.add(newCollection);
    }
    // utworzenie listy widgetów na podstawie danych z hive
    for (int i = 0; i < collections[0].elements.length; i++)
      (
        _addedWidgets.add(
          DraggableWidget(
            // todo sprawdzanie poprawności ścieżki
            child: File(collections[0].elements[i].path).existsSync()
                ? Image.file(
                    File(
                      collections[0].elements[i].path,
                    ),
                    fit: BoxFit.fitWidth)
                : Icon(
                    Icons.block_outlined,
                    size: 50,
                  ),
          ),
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container()),

          // Wyświetla wszystkie elementy z kolekcji
          for (int i = 0; i < _addedWidgets.length; i++) _addedWidgets[i],

          // todo śmietnik dla elemetów kolekcji
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          //dodawanie elementu do kolekcji
          onPressed: () {
            setState(
              () {
                if (_addedWidgets.length < 10) {
                  _addedWidgets.add(
                    DraggableWidget(
                      initMatrix4: Boxes.m4,
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.file(File(elements[0].path))),
                    ),
                    _addHiveElement(),
                  );
                  print(_addedWidgets.length);
                }
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

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
    )
  ];

  void _addHiveElement() {
    // CollectionElement element = CollectionElement(
    //   name: 'name',
    //   path: path,
    //   matrix4: Matrix4.identity(),
    // );

    // final box = Boxes.getCollection();
    // var collection = box.getAt(0) as Collection;
    // collection.elements.add(element);
  }
}
