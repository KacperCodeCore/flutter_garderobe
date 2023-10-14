import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class SingleElement extends StatelessWidget {
  final String name;
  final String path;
  final double height;
  // final Image? imageSorce;

  const SingleElement({
    super.key,
    required this.name,
    required this.path,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Text(
              '$name $height',
            ),
          ),
          Container(
            height: height,
            child: File(path).existsSync()
                ? Image.file(
                    File(
                      path,
                    ),
                    fit: BoxFit.fitWidth)
                : Icon(Icons.not_accessible),
          ),
        ],
      ),
    );
  }
}
