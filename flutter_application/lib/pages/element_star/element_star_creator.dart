import 'package:flutter/material.dart';

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
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
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
          // FloatingActionButton(
          //   backgroundColor: Colors.blue,
          //   onPressed: () {},
          //   child: Icon(Icons.save), // Możesz zmienić ikonę na odpowiednią
          // ),
        ],
      ),
    );
  }
}
