import 'package:flutter/material.dart';

import '../../data/boxes.dart';
import '../../data/collection.dart';
import 'user_post.dart';

class UserHome extends StatelessWidget {
  var collections = Boxes.getCollection().values.toList().cast<Collection>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return UserPost(
            name: collections[index].name,
            path: collections[index].screenshotPath,
          );
        },
      ),
    );
  }
}
