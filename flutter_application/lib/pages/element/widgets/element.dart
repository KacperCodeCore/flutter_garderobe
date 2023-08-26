import 'dart:io';
import 'package:flutter/material.dart';

class Element extends StatelessWidget {
  final File? file;

  const Element({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
