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
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 15),
      child: Center(
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
                        // fontWeight: FontWeight.bold,
                        color: Colors.black, // <-- Inner color
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // return Column(
  //   children: [
  //     // // nagłówek
  //     // Container(
  //     //   height: 50,
  //     //   decoration: BoxDecoration(
  //     //     color: _color1,
  //     //     border: Border.all(
  //     //       color: _color2,
  //     //       width: 2,
  //     //     ),
  //     //     borderRadius: BorderRadius.only(
  //     //       topLeft: Radius.circular(25),
  //     //       topRight: Radius.circular(25),
  //     //     ),
  //     //   ),
  //     //   padding: const EdgeInsets.all(0.0),
  //     //   child: Row(
  //     //     mainAxisAlignment: MainAxisAlignment.center,
  //     //     children: [
  //     //       Text(
  //     //         name,
  //     //         style: TextStyle(fontSize: 30),
  //     //       ),
  //     //     ],
  //     //   ),
  //     // ),

  //     //Post
  //     Container(
  //       // width: screenWidth,

  //       // decoration: BoxDecoration(
  //       //   border: Border(
  //       //     bottom: BorderSide(
  //       //       color: _color2,
  //       //       width: 2,
  //       //     ),
  //       //     left: BorderSide(
  //       //       color: _color2,
  //       //       width: 2,
  //       //     ),
  //       //     right: BorderSide(
  //       //       color: _color2,
  //       //       width: 2,
  //       //     ),
  //       //   ),
  //       // ),
  //       child: child,
  //     ),
  //   ],
  // );
}
