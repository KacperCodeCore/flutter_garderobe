import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Garderobe extends StatefulWidget {
  final int initIndex;
  final Function(int) onShelfUpdate;

  const Garderobe({
    super.key,
    required this.onShelfUpdate,
    required this.initIndex,
  });

  @override
  _GarderobeState createState() => _GarderobeState();
}

class _GarderobeState extends State<Garderobe> {
  final Color _color1 = Colors.brown.shade400;
  final Color _color2 = Colors.brown.shade800;
  final Color _colorSelected = Colors.brown.shade200;
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initIndex;
    super.initState();
  }

  Widget buildSegment(
      int index, int rowStart, int columnStart, int rowSpan, int columnSpan) {
    Color segmentColor = index == _selectedIndex ? _colorSelected : _color1;

    return Container(
      decoration: BoxDecoration(
        color: segmentColor,
        border: Border.all(width: 4, color: _color2),
      ),
      child: MaterialButton(
        onPressed: () {
          if (_selectedIndex == index)
            _selectedIndex = 0;
          else
            _selectedIndex = index;

          widget.onShelfUpdate(_selectedIndex);
          setState(() {});
        },
        child: Center(
          child: Text('$index'),
        ),
      ),
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
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0),
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
                  buildSegment(1, 0, 0, 3, 1),
                  buildSegment(2, 0, 1, 1, 1),
                  buildSegment(3, 1, 1, 1, 1),
                  buildSegment(4, 2, 1, 1, 1),
                  buildSegment(5, 3, 0, 1, 1),
                  buildSegment(6, 3, 1, 1, 1),
                ],
              ),
            ),
          ),
          // Legs
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
