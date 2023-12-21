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
    Color _color1 = Colors.brown.shade300;
    Color _color2 = Colors.brown.shade300;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // nagłówek
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: _color1,
            border: Border.all(
              color: _color2,
              width: 2,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),

        //Post
        Container(
          // width: screenWidth,
          height: 500,
          // decoration: BoxDecoration(
          //   border: Border(
          //     bottom: BorderSide(
          //       color: _color2,
          //       width: 2,
          //     ),
          //     left: BorderSide(
          //       color: _color2,
          //       width: 2,
          //     ),
          //     right: BorderSide(
          //       color: _color2,
          //       width: 2,
          //     ),
          //   ),
          // ),
          child: child,
        ),
      ],
    );
  }
}
