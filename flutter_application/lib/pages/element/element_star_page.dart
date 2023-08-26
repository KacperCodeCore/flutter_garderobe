import 'package:flutter/material.dart';
import 'package:flutter_application/pages/element/widgets/element_star.dart';

class ElementStarPage extends StatefulWidget {
  const ElementStarPage({super.key});

  @override
  State<ElementStarPage> createState() => _ElementStarPageState();
}

class _ElementStarPageState extends State<ElementStarPage> {
  //element list
  List elementList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      appBar: AppBar(
        title: Text('Your elements'),
      ),
      //floating acion button
      body: ListView.builder(
        itemCount: 3, //elementList.length,
        itemBuilder: (BuildContext context, int index) {
          return ElementStar();
        },
      ),
    );
  }
}
