import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';

class UserPost extends StatelessWidget {
  final String name;
  final String path;

  UserPost({
    required this.name,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // profile logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // nick name
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // menu icon
              Icon(Icons.menu),
            ],
          ),
        ),
        //Post
        Container(
          height: 500,
          child: Image.file(File(path)),
        ),
        // below the post
        Padding(
          padding: const EdgeInsets.all(0.0),
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
        )
      ],
    );
  }
}
