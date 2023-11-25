import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;
  final double initX;
  final double initY;
  final double initScale;
  final double initRotation;
  final Matrix4? initMatrix4;
  final Function onDoubleTap;
  final Function(Matrix4, String) onSave;

  DraggableWidget({
    Key? key,
    required this.child,
    this.initX = 0.0,
    this.initY = 0.0,
    this.initScale = 1.0,
    this.initRotation = 0.0,
    this.initMatrix4 = null,
    required this.onDoubleTap,
    required this.onSave,
  }) : super(key: key);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();

  void dispose() {
    //todo
  }
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Matrix4 initialMatrix = Matrix4.identity();
  Matrix4 currentMatrix = Matrix4.identity();
  bool isBeingUsed = false;
  late Timer timer;
  late bool canOneTime;

  late ValueNotifier<Matrix4> notifier;

  void onDoubleTap() {
    print('DoubleTap!!!');
  }

  void onTap() {
    print('tap!!!');
  }

  void onTapCancel() {
    print('onTapCancel!!!');
  }

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
    }
    notifier = ValueNotifier(initialMatrix);
    timer = Timer(Duration.zero, () {});

    canOneTime = true;
  }

  @override
  Widget build(BuildContext context) {
    //służy do init matrix4 przy każdym odświerzeniu
    // bool.useOneTime = true;
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        if (canOneTime) {
          currentMatrix = m..multiply(initialMatrix);
          canOneTime = false;
        }
        notifier.value = m;

        // chwilę po przestaniu korzystana z widgetu następuje onSave
        if (timer.isActive) {
          timer.cancel();
        }
        timer = Timer(
          Duration(milliseconds: 100),
          () {
            isBeingUsed = false;
            widget.onSave(notifier.value, 'onSave was initiated!!!!!!!!!');
          },
        );

        isBeingUsed = true;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, childWidget) {
          return Transform(
            transform: notifier.value,
            child: GestureDetector(
              onDoubleTap: onDoubleTap,
              onTap: onTap,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Dodaj tę linię
    // Boxes.m4 = notifier.value;
    notifier.dispose();
    super.dispose();
  }
}
