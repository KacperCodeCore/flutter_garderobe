import 'dart:io';
import 'package:flutter/material.dart';

class Element extends StatelessWidget {
  final File? file;

  const Element({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color.fromARGB(255, 216, 97, 54),
            width: 3,
          ),
        ),
        child: file != null
            ? Image.file(file!)
            : Icon(
                Icons.error_outline,
                size: 100,
              ),
      ),
    );
  }
}
