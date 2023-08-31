import 'package:flutter/material.dart';

class ElementStarCreator extends StatelessWidget {
  VoidCallback onSave;
  ElementStarCreator({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star Edit')),
      backgroundColor: Colors.amber,
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: onSave,
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }
}
