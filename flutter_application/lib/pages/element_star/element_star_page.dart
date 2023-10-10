import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/element_star/element_star.dart';
import 'package:flutter_application/pages/element_star/element_star_creator.dart';

class ElementStarPage extends StatefulWidget {
  const ElementStarPage({super.key});

  @override
  State<ElementStarPage> createState() => _ElementStarPageState();
}

class _ElementStarPageState extends State<ElementStarPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();

  Future<void> _addMyElement(String name, String path) async {
    var newElement = MyElement(
      name: name,
      path: path,
    );
    final box = Boxes.getMyElements();
    box.add(newElement); // Dodanie elementu do Box.

    setState(() {
      elements = box.values.toList().cast<MyElement>();
    });
  }

  void _deleteElement(MyElement element) async {
    Boxes.getMyElements().delete(element);
    final box = Boxes.getMyElements();
    var index = box.values.toList().cast<MyElement>().indexOf(element);
    setState(
      () {
        box.deleteAt(index);
        elements = box.values.toList().cast<MyElement>();
      },
    );
  }

  void updateElement(String name, String path, int index) {
    final myElement = elements[index];

    setState(() {
      elements[index].name = name;
      elements[index].path = path;
    });
    Boxes.getMyElements().put(myElement.id, myElement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(
        title: Text('Your elements'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ElementStarCreator(
                  name: 'New Element',
                  imagePath: 'path',
                  onSave: (name, path) => _addMyElement(name, path),
                  onDelete: () {}),
            ),
          ),
        },
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ElementStar(
              name: elements[index].name,
              path: elements[index].path,
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ElementStarCreator(
                      name: elements[index].name,
                      imagePath: elements[index].path,
                      onSave: (name, path) => updateElement(name, path, index),
                      onDelete: () => {
                            _deleteElement(elements[index]),
                          }),
                ),
              ),
            },
          );
        },
      ),
    );
  }
}
