import 'package:flutter/material.dart';

import 'user_post.dart';

class UserHome extends StatelessWidget {
  final List<String> postNames = ['kacper', 'John', 'Alice', 'Bob'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: postNames.length,
        itemBuilder: (context, index) {
          return UserPost(
            name: postNames[index],
          );
        },
      ),
    );
  }
}
