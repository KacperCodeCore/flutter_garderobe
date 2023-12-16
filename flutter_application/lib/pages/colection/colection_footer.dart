import 'package:flutter/material.dart';

class ColectionFooter extends StatelessWidget {
  const ColectionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Row(
          children: [
            Icon(Icons.favorite),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.chat),
            ),
            Icon(Icons.share),
          ],
        ),
        // Spacer(),
        Icon(Icons.bookmark)
      ],
    );
  }
}
