import 'package:flutter/material.dart';

class ElementStar extends StatelessWidget {
  final String name;
  // final Image? imageSorce;

  const ElementStar({
    super.key,
    required this.name,
    // required this.imageSorce,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              children: [Text(name)],
            ),
            Row(
              children: [
                Container(
                  height: 400,
                  width: 300,
                  // child: Image.file(File(imagePath)),)
                ),
                Container(
                  height: 400,
                  width: 40,
                  color: Colors.amber.shade800,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
