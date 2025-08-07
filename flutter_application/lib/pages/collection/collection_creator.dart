import 'package:flutter/material.dart';

class CollectionCreator extends StatelessWidget {
  final String name;
  final Widget child;

  CollectionCreator({
    required this.name,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController(text: name);
    return Center(
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
                    // controller: _textController,
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
                    // controller: _textController,
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
    );
  }
}
