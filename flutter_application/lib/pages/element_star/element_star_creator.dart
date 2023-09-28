import 'package:flutter/material.dart';
import 'package:flutter_application/pages/element_star/element_star_page.dart';
import 'package:flutter_application/pages/home/homepage.dart';

class ElementStarCreator extends StatefulWidget {
  final String name;
  final String path;
  final Function(String, String) onSave;

  ElementStarCreator({
    Key? key,
    required this.name,
    required this.path,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ElementStarCreator> createState() => _ElementStarCreatorState();
}

class _ElementStarCreatorState extends State<ElementStarCreator> {
  @override
  void initState() {
    _controller = TextEditingController(text: widget.name);
    super.initState();
  }

  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star Edit')),
      backgroundColor: Colors.amber,
      body: Container(
        child: Column(
          children: [
            TextField(controller: _controller),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dodaj przyciski nawigacji tutaj, np. BottomNavigationBarItem
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min, // Użyj MainAxisSize.min
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              widget.onSave(_controller.text, widget.path);
              Navigator.of(context).pop();
            },
            child: Icon(Icons.save), // Możesz zmienić ikonę na odpowiednią
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {},
            child: Icon(Icons.save), // Możesz zmienić ikonę na odpowiednią
          ),
        ],
      ),
    );
  }
}
