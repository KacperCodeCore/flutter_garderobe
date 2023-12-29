import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/boxes.dart';
import '../../data/colection.dart';
import 'user_post.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var colections = Boxes.getColection().values.toList().cast<Colection>();

  void _onLikeitPress(int index, Colection collection) async {
    collection.likeIt = !collection.likeIt;

    Boxes.getColection().putAt(index, collection);
    setState(() {
      colections = Boxes.getColection().values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: colections.length,
        itemBuilder: (context, index) {
          return UserPost(
            name: colections[index].name,
            path: colections[index].screenshotPath,
            likeIt: colections[index].likeIt,
            onLikeItPress: () {
              _onLikeitPress(index, colections[index]);
            },
          );
        },
      ),
    );
  }
}
