import 'package:flutter/material.dart';

class ElementStar extends StatelessWidget {
  // const ElementStar({super.key});
  const ElementStar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: SizedBox(
        child: Row(
          children: [
            Container(
              height: 400,
              width: 300,
              child: Image(image: AssetImage('images/1.png')),
            ),
            Container(
              height: 400,
              width: 40,
              color: Colors.amber.shade800,
            ),
          ],
        ),
      ),
    );
  }
}
