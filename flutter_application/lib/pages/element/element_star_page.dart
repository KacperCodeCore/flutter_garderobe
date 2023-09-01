import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/database.dart';
import 'package:flutter_application/pages/element/element_star/element_star_creator.dart';
import 'package:flutter_application/pages/element/widgets/element_star.dart';
import 'package:animations/animations.dart';
import 'package:flutter_application/pages/element_creator/element_heroe_creator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ElementStarPage extends StatefulWidget {
  const ElementStarPage({super.key});

  @override
  State<ElementStarPage> createState() => _ElementStarPageState();
}

class _ElementStarPageState extends State<ElementStarPage> {
  //reference to Hive
  final _myBox = Hive.box('myBox');
  ElementDataBase db = ElementDataBase();

  @override
  void initState() {
    if (_myBox.get("ELEMENTLIST") == null) {
      //if this is 1st time ever opening the app, then create default data
      db.createInitialData();
    } else {
      //if there arleady exist data
      db.loadData();
    }
    super.initState();
  }

  //save new element
  void addElement(String name) {
    setState(() {
      db.elementList.add([name]);
    });
    db.updateData();
    // Navigator.of(context).pop();
  }

  void updateElement(String name, int index) {
    setState(() {
      db.elementList[index][0] = name;
    });
    db.updateData();
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
          onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ElementStarCreator(
                          name: 'New Element',
                          onSave: addElement,
                          // title: 'New Element',
                        )))
              }),
      body: ListView.builder(
        itemCount: db.elementList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ElementStar(
              name: db.elementList[index][0],
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ElementStarCreator(
                        name: db.elementList[index][0],
                        onSave: (name) => updateElement(name, index),
                      )))
            },
          );
        },
      ),
    );
  }
}
