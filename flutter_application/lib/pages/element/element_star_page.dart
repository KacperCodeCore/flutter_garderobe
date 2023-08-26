import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/element/element_star/element_star_creator.dart';
import 'package:flutter_application/pages/element/widgets/element_star.dart';
import 'package:animations/animations.dart';
import 'package:flutter_application/pages/element_creator/element_heroe_creator.dart';

class ElementStarPage extends StatefulWidget {
  const ElementStarPage({super.key});

  @override
  State<ElementStarPage> createState() => _ElementStarPageState();
}

class _ElementStarPageState extends State<ElementStarPage> {
  //element list
  List elementList = [
    ['Staff 1'],
    ['Staff 2']
  ];

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
                    builder: (context) => ElementStarCreator()))
              }),
      body: ListView.builder(
        itemCount: elementList.length,
        itemBuilder: (BuildContext context, int index) {
          return ElementStar(
            name: elementList[index][0],
          );
        },
      ),
    );
  }
}
