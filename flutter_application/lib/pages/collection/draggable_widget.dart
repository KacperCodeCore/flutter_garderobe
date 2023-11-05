import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;
  final double initX;
  final double initY;
  final double initScale;
  final double initRotation;
  final Matrix4? initMatrix4;

  DraggableWidget({
    Key? key,
    required this.child,
    this.initY = 0.0,
    this.initX = 0.0,
    this.initScale = 1.0,
    this.initRotation = 0.0,
    this.initMatrix4 = null,
  }) : super(key: key);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Matrix4 initialMatrix = Matrix4.identity();
  Matrix4 currentMatrix = Matrix4.identity();

  late ValueNotifier<Matrix4> notifier;

  @override
  void initState() {
    super.initState();
    if (widget.initMatrix4 != null) {
      initialMatrix = widget.initMatrix4!.clone();
    } else {
      initialMatrix
        ..translate(widget.initY, widget.initX)
        ..scale(widget.initScale)
        ..rotateZ(widget.initRotation);
      // currentMatrix = Matrix4.identity()..multiply(initialMatrix);
    }
    notifier = ValueNotifier(initialMatrix);
  }

  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        // currentMatrix = m..multiply(initialMatrix); // może zmienić?
        currentMatrix = m.clone()..multiply(initialMatrix);
        notifier.value = currentMatrix;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, childWidget) {
          return Transform(
            transform: notifier.value,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.contain,
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Boxes.m4 = notifier.value;
    notifier.dispose();
    super.dispose();
  }
}
