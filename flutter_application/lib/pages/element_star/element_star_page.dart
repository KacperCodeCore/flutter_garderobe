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

  // @override
  // void initState() {
  //   if (_myBox.get("ELEMENTLIST") == null) {
  //     //if this is 1st time ever opening the app, then create default data
  //     db.createInitialData();
  //   } else {
  //     //if there arleady exist data
  //     db.loadData();
  //   }
  //   super.initState();
  // }

  //save new element
  // void addElement(String name) {
  //   setState(() {
  //     db.elementList.add([name]);
  //   });
  //   db.updateData();
  //   // Navigator.of(context).pop();
  // }
  Future<void> _addMyElement(String name, String path) async {
    var newElement = MyElement(
      name: name,
      path: path,
    );
    final box = Boxes.getMyElements();
    box.add(newElement); // Dodanie elementu do Box.

    // Po dodaniu elementu, możemy zaktualizować listę elementów 'element'.
    setState(() {
      elements = box.values.toList().cast<MyElement>();
    });
  }

  void _deleteElement(int index) {
    final box = Boxes.getMyElements();
    box.deleteAt(index);
    setState(() {
      elements = box.values.toList().cast<MyElement>();
      // elements.removeAt(index)
    });
  }

  void updateElement(String name, String path, int index) {
    setState(() {
      elements[index].name = name;
      elements[index].path = path;
    });
    // db.updateData();
  }

  get editElementCallback => null;

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
                  onDelete: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        },
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ElementStar(
              name: elements[index].name + "  " + elements[index].path,
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
                            Navigator.of(context).pop(),
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