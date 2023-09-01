import 'dart:async';

import 'package:flutter/material.dart';

class ElementStarCreator extends StatefulWidget {
  final String name;
  final Function(String) onSave;

  ElementStarCreator({
    Key? key,
    required this.name,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          widget.onSave(_controller.text),
          Navigator.of(context).pop(),
        },
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
