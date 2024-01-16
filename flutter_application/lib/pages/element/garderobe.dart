import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Garderobe extends StatelessWidget {
  final Color _color1 = Colors.brown.shade400;
  final Color _color2 = Colors.brown.shade800;

  Widget buildSegment(
      int index, int rowStart, int columnStart, int rowSpan, int columnSpan) {
    return Container(
      decoration: BoxDecoration(
        color: _color1,
        border: Border.all(width: 4, color: _color2),
      ),
      child: Center(child: Text('$index')),
    ).withGridPlacement(
      columnStart: columnStart,
      rowStart: rowStart,
      columnSpan: columnSpan,
      rowSpan: rowSpan,
    );
  }

  Widget buildLeg() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: _color2,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Garderobe
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: _color2,
            ),
            height: 600,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 15),
              child: LayoutGrid(
                columnSizes: [1.fr, 1.fr],
                rowSizes: [auto, auto, auto, auto],
                children: [
                  //
                  buildSegment(0, 0, 0, 3, 1),
                  buildSegment(1, 0, 1, 1, 1),
                  buildSegment(2, 1, 1, 1, 1),
                  //
                  buildSegment(3, 2, 1, 1, 1),
                  //
                  buildSegment(4, 3, 0, 1, 1),
                  buildSegment(5, 3, 1, 1, 1),
                ],
              ),
            ),
          ),
          //foots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLeg(),
              buildLeg(),
            ],
          )
        ],
      ),
    );
  }
}
