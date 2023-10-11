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
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/wood.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Icon(
            Icons.favorite,
            size: 120,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
