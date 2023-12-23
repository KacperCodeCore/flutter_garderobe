import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/element/element_bottom_sheet.dart';

import 'package:flutter_application/pages/element/single_element.dart';
import 'package:flutter_application/pages/element/element_creator.dart';

class ElementPage extends StatefulWidget {
  const ElementPage({super.key});

  @override
  State<ElementPage> createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();

  Future<void> _addMyElement(String name, String path, double height,
      double width, ClotherType type) async {
    var newElement = MyElement(
      name: name,
      path: path,
      height: height,
      width: width,
      type: type,
    );
    Boxes.getMyElements().add(newElement);

    setState(() {
      elements = Boxes.getMyElements().values.toList().cast<MyElement>();
    });
  }

  Future<void> _addMyElement1(MyElement myElement) async {
    Boxes.getMyElements().add(myElement);

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

  void updateElement(String name, String path, double height, double widht,
      ClotherType type, int index) {
    final myElement = elements[index];

    setState(() {
      elements[index].name = name;
      elements[index].path = path;
      elements[index].height = height;
      elements[index].width = widht;
      elements[index].type = type;
    });
    Boxes.getMyElements().put(myElement.id, myElement);
  }

  void _updateElement1(MyElement myElement) {
    Boxes.getMyElements().put(myElement.id, myElement);
  }

  void _showBottomSheet(MyElement? myElement) {
    showModalBottomSheet(
      backgroundColor: Colors.brown.shade400,
      context: context,
      builder: (BuildContext context) {
        return ElementBottomSheet(
          myElement: myElement,
          add: (e) {
            _addMyElement1(e);
          },
          // update: (e) => _updateElement1(e),
          update: (e) {
            _updateElement1(e);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown.shade300,

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
                        type: elements[index].type,
                        onSave: (name, path, height, width, type) =>
                            updateElement(
                                name, path, height, width, type, index),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showBottomSheet(null);
          },
        ),
      ),
    );
  }
}
