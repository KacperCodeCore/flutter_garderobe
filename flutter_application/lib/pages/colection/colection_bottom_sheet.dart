import 'package:flutter/material.dart';

class ColectionBottomSheet extends StatefulWidget {
  const ColectionBottomSheet({super.key});

  @override
  State<ColectionBottomSheet> createState() => _ColectionBottomSheetState();
}

class _ColectionBottomSheetState extends State<ColectionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.brown.shade800,
      ),
      height: 400,
    );
  }
}
