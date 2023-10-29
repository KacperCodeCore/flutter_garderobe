import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;

  //Zmienne do przechowywania pozycji
  final double initialX;
  final double initialY;
  double x;
  double y;
  double rotation;
  double scale;

  DraggableWidget({
    Key? key,
    required this.child,
    this.initialX = 0.0,
    this.initialY = 0.0,
    required this.x,
    required this.y,
    this.rotation = 0.0,
    this.scale = 1.0,
  }) : super(key: key);

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
