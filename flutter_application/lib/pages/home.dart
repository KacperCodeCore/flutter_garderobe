import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  // const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('MyGarderobe'),
            Icon(Icons.add),
            Icon(Icons.favorite),
            Icon(Icons.share),
          ],
        ),
      ),
      body: const Center(child: Text('Hom')),
    );
  }
}
