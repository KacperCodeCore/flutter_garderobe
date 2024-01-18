import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/element/element_bottom_sheet.dart';
import 'package:flutter_application/pages/element/garderobe.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ElementPage extends StatefulWidget {
  const ElementPage({super.key});

  @override
  State<ElementPage> createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  List<MyElement> elements = [];
  List<MyElement> elementsShelfIndex = [];
  Map<int?, List<MyElement>> groupedElements = {};
  int shelfIndex = 0;

  @override
  void initState() {
    elements = Boxes.getMyElements().values.toList().cast<MyElement>();

    _updateElementList();

    super.initState();
  }

  void _updateElementList() {
    // for (ClotheType type in uniqueType)
    //   groupedElements[type] =
    //       elements.where((element) => element.type == type).toList();

    groupedElements[shelfIndex] =
        elements.where((element) => element.shelfIndex == shelfIndex).toList();
  }

  void handleFABPress_0() {
    _showBottomGarderobe();
  }

  void handleFABPress_1() {
    _showBottomSheet(null, false);
  }

  void _addMyElement(MyElement myElement) async {
    Boxes.getMyElements().add(myElement);
    setState(() {
      elements = Boxes.getMyElements().values.toList().cast<MyElement>();
    });
  }

  void _deleteElement(MyElement myElement) async {
    _deleteImage(myElement.path);
    // Boxes.getMyElements().delete(element);
    final box = Boxes.getMyElements();
    var index = box.values.toList().cast<MyElement>().indexOf(myElement);
    box.deleteAt(index);
    setState(
      () {
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

  void _updateElement(MyElement myElement) async {
    int index = elements.indexWhere((e) => e.id == myElement.id);
    if (index == -1) return;

    Boxes.getMyElements().putAt(index, myElement);
    setState(() {
      elements = Boxes.getMyElements().values.toList();
    });
  }

  void _showBottomGarderobe() {
    print(shelfIndex);

    print(groupedElements[shelfIndex]);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Garderobe(
          onShelfUpdate: (index) {
            setState(() {
              shelfIndex = index;
              _updateElementList();
            });
            print(shelfIndex);
          },
          initIndex: 1,
        );
      },
    );
  }

  void _showBottomSheet(MyElement? myElement, bool isEdited) {
    //todo remove ↓
    if (myElement != null) {
      print(myElement.shelfIndex);
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ElementBottomSheet(
          myElement: myElement,
          isEdited: isEdited,
          add: (e) {
            _addMyElement(e);
            Navigator.of(context).pop();
          },
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
      body:
          //https://www.youtube.com/watch?v=AloeoaZhjS8&ab_channel=MitchKoko
          MasonryGridView.builder(
        //todo
        itemCount: groupedElements[shelfIndex] == null
            ? 0
            : groupedElements[shelfIndex]!.length,
        gridDelegate:
            SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 2, left: 1, right: 1),
            child: Container(
              // height: elements[index].height,
              height: groupedElements[shelfIndex]![index].height,
              width: groupedElements[shelfIndex]![index].height,
              decoration: BoxDecoration(
                color: Colors.brown.shade400,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: GestureDetector(
                  child: Image.file(
                      File(File(groupedElements[shelfIndex]![index].path)
                              .existsSync()
                          ? elements[index].path
                          : '${Boxes.appDir}/null.png'),
                      fit: BoxFit.fitWidth),
                  onTap: () => {_showBottomSheet(elements[index], true)},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
