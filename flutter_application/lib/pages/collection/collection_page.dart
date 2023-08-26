import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Collection'),
            Row(
              children: [
                Icon(Icons.abc),
                Icon(Icons.abc),
              ],
            ),
          ],
        ),
      ),
      body: Center(child: Text('Garderobe')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
