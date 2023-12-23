import 'package:flutter/material.dart';

import '../../data/boxes.dart';
import '../../data/colection.dart';
import 'user_post.dart';

class UserHome extends StatelessWidget {
  // var colections = Boxes.getColection().values.toList().cast<Colection>();
  var colections;

  @override
  Widget build(BuildContext context) {
    colections = Boxes.getColection().values.toList().cast<Colection>();
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.brown.shade400,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 400,
                );
              });
        }),
      ),
    );
  }
}