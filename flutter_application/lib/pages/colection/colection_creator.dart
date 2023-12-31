import 'package:flutter/material.dart';

class ColectionCreator extends StatelessWidget {
  final String name;
  final Widget child;

  ColectionCreator({
    required this.name,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        // padding: const EdgeInsets.only(top: 15, bottom: 15),
        // child:
        Center(
      child: Stack(
        children: [
          //container
          child,
          //Tite
          Positioned(
            top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Center(
                  child: Stack(
                children: <Widget>[
                  Text(
                    //https://stackoverflow.com/questions/70874150/how-to-use-both-the-text-color-and-foreground-color-properties-together
                    name,
                    style: TextStyle(
                      fontFamily: 'Kalam-Regular',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.brown.shade200, // <-- Border color
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Kalam-Regular',
                      fontSize: 40,
                      color: Colors.brown.shade900, // <-- Inner color
                    ),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
