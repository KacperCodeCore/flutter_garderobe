import 'package:flutter/material.dart';

class UserPost extends StatelessWidget {
  final String name;

  UserPost({required this.name});

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
          height: 400,
          color: Colors.grey,
        ),
        // below the post
        Padding(
          padding: const EdgeInsets.all(16.0),
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
