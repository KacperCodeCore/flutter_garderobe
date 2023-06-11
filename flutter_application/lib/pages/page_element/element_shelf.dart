import 'package:flutter/material.dart';

class ElementShelf extends StatelessWidget {
  const ElementShelf({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.brown,
            width: 3,
          ),
        ),
      ),
    );
  }
}
