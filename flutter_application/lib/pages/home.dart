import 'package:flutter/material.dart';
import 'package:flutter_application/pages/user_post.dart';

class UserHome extends StatelessWidget {
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
      body: Column(children: [
        UserPost(name: "kacper"),
      ]),
    );
  }
}
