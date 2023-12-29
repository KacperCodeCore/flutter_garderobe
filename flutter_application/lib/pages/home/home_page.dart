import 'package:flutter/material.dart';

import '../../data/boxes.dart';
import '../../data/colection.dart';
import 'user_post.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    final colections = Boxes.getColection().values.toList().cast<Colection>();
    return Scaffold(
      body: ListView.builder(
        itemCount: colections.length,
        itemBuilder: (context, index) {
          return UserPost(
            name: colections[index].name,
            path: colections[index].screenshotPath,
          );
        },
      ),
    );
  }
}
