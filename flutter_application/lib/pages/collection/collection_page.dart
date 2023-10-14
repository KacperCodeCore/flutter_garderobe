import 'package:flutter/material.dart';
import 'package:flutter_application/pages/collection/overlayed_widget.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<Widget> _addedWidgets = [];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/wood.jpg',
              fit: BoxFit.cover,
            ),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _addedWidgets.add(OverlaydWidget(
              child: _dummyWidgets.elementAt(_addedWidgets.length),
            ));
            print(_addedWidgets.length);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  final List<Widget> _dummyWidgets = [
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
