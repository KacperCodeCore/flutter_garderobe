import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/element/element_bottom_sheet.dart';
import 'package:flutter_application/pages/element/single_element.dart';

class ElementPage extends StatefulWidget {
  const ElementPage({super.key});

  @override
  State<ElementPage> createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  void handleFABPress() {
    _showBottomSheet(null, false);
  }

  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();

  void _addMyElement(MyElement myElement) async {
    setState(() {
      Boxes.getMyElements().add(myElement);
      elements = Boxes.getMyElements().values.toList().cast<MyElement>();
    });
  }

  void _deleteElement(MyElement element) async {
    _deleteImage(element.path);
    // Boxes.getMyElements().delete(element);
    final box = Boxes.getMyElements();
    var index = box.values.toList().cast<MyElement>().indexOf(element);
    setState(
      () {
        // todo gdy element jest pusty, to jest błąd
        box.deleteAt(index);
        elements = box.values.toList().cast<MyElement>();
      },
    );
  }

  void _deleteImage(String path) async {
    try {
      File imageFile = File(path);
      if (imageFile.existsSync()) {
        await imageFile.delete();
      }
    } catch (e) {
      print("element_page _deleteImage error: $e");
    }
  }

  void _updateElement(MyElement myElement) {
    //todo error?
    Boxes.getMyElements().put(myElement.id, myElement);
    setState(() {
      elements = Boxes.getMyElements().values.toList();
    });
  }

  void _showBottomSheet(MyElement? myElement, bool isEdited) {
    showModalBottomSheet(
      // scrollControlDisabledMaxHeightRatio: ,
      //todo o to robi?
      isScrollControlled: true,
      backgroundColor: Colors.brown.shade400,
      context: context,
      builder: (BuildContext context) {
        return ElementBottomSheet(
          myElement: myElement,
          isEdited: isEdited,
          add: (e) {
            _addMyElement(e);
            Navigator.of(context).pop();
          },
          // update: (e) => _updateElement1(e),
          update: (e) {
            _updateElement(e);
            Navigator.of(context).pop();
          },
          delete: (e) {
            _deleteElement(e);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () => {_showBottomSheet(elements[index], true)},
            );
          },
        ),
      ),
    );
  }
}
