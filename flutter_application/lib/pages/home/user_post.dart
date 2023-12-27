import 'dart:io';

import 'package:flutter/material.dart';

class UserPost extends StatelessWidget {
  final String name;
  final String? path;

  UserPost({
    required this.name,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          height: 700,
          child: path != null ? Image.file(File(path!)) : null,
        ),
        // if (path != null) Image(image: FileImage(File(path!))),

        // below the post
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.favorite),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.chat),
                  ),
                  Icon(Icons.share),
                ],
              ),
              // Spacer(),
              Icon(Icons.bookmark)
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
