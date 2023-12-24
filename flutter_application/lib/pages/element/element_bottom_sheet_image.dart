import 'package:flutter/material.dart';

class ElementBottomSheetImage extends StatefulWidget {
  const ElementBottomSheetImage({super.key});

  @override
  State<ElementBottomSheetImage> createState() =>
      _ElementBottomSheetImageState();
}

class _ElementBottomSheetImageState extends State<ElementBottomSheetImage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: 200,
        ),
      ],
    );
  }
}
