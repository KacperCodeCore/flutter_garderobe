import 'package:flutter/material.dart';

import 'pages/home/user_post.dart';

class UserHome extends StatelessWidget {
  final List<String> postNames = ['kacper', 'John', 'Alice', 'Bob'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MyGarderobe'),
            Row(
              children: [
                Icon(Icons.add),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(Icons.favorite),
                ),
                Icon(Icons.share),
              ],
            )
          ],
        ),
      ),
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
