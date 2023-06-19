import 'package:flutter/material.dart';

class Shelf_1 extends StatelessWidget {
  final Image image;
  const Shelf_1({required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 20,
        child: Image(image: image.image),
      ),
    );
  }
}
