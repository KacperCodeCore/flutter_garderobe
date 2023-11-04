import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/overlayed_widget.dart';

import '../../data/boxes.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  List<Widget> _addedWidgets = [];

  @override
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
          for (int i = 0; i < _addedWidgets.length; i++) _addedWidgets[i],
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
          onPressed: () {
            setState(
              () {
                if (_addedWidgets.length < 10 && elements.length > 0) {
                  _addedWidgets.add(
                    OverlaydWidget(
                      initMatrix4: Boxes.m4,
                      // child: _dummyWidgets.elementAt(_addedWidgets.length),
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.file(File(elements[0].path))),
                    ),
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
    // Positioned(

    //   child: Container(
    //     width: 100,
    //     height: 100,
    //   ),
    // ),
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
}
