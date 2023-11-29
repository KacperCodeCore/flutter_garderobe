import 'package:flutter/material.dart';

import '../../data/boxes.dart';
import '../../data/collection.dart';
import 'user_post.dart';

class HomePage extends StatelessWidget {
  var collections = Boxes.getCollection().values.toList().cast<Collection>();
  final List<String> postNames = ['kacper', 'John', 'Alice', 'Bob'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            color: Colors.red,
          );
          // return UserPost(
          //   name: collections[index].name,
          //   path: collections[index].path,
          // );
        },
      ),
    );
  }
}
