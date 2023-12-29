import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Image.file(
                File(File(path).existsSync()
                    ? path
                    : '${Boxes.appDir}/null.png'),
                fit: BoxFit.fitWidth),
          ),
        ),
      ],
    );
  }
}
