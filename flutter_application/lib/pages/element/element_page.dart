import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/element/single_element.dart';
import 'package:flutter_application/pages/element/element_creator.dart';

class ElementPage extends StatefulWidget {
  const ElementPage({super.key});

  @override
  State<ElementPage> createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();

  Future<void> _addMyElement(
      String name, String path, double height, double width) async {
    var newElement = MyElement(
      name: name,
      path: path,
      height: height,
      width: width,
    );
    Boxes.getMyElements().add(newElement);

    setState(() {
      elements = Boxes.getMyElements().values.toList().cast<MyElement>();
    });
  }

  void _deleteElement(MyElement element) async {
    // Boxes.getMyElements().delete(element);
    final box = Boxes.getMyElements();
    var index = box.values.toList().cast<MyElement>().indexOf(element);
    setState(
      () {
        box.deleteAt(index);
        elements = box.values.toList().cast<MyElement>();
      },
    );
  }

  void updateElement(
      String name, String path, double height, double widht, int index) {
    final myElement = elements[index];

    setState(() {
      elements[index].name = name;
      elements[index].path = path;
      elements[index].height = height;
      elements[index].width = widht;
    });
    Boxes.getMyElements().put(myElement.id, myElement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                // todo dwa razy korzystam z ElementCreator() i działa to delikatnie ineczej, czy można to naprawić?
                builder: (context) => ElementCreator(
                    name: 'New Element',
                    imagePath: 'path',
                    height: 200,
                    width: 200,
                    onSave: (name, path, height, width) =>
                        _addMyElement(name, path, height, width),
                    onDelete: () {}),
              ),
            ),
          },
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: elements.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: SingleElement(
                name: elements[index].name,
                path: elements[index].path,
                height: elements[index].height,
              ),
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ElementCreator(
                        name: elements[index].name,
                        imagePath: elements[index].path,
                        height: elements[index].height,
                        width: elements[index].width,
                        onSave: (name, path, height, width) =>
                            updateElement(name, path, height, width, index),
                        onDelete: () => {
                              _deleteElement(elements[index]),
                            }),
                  ),
                ),
              },
            );
          },
        ),
      ),
    );
  }
}
