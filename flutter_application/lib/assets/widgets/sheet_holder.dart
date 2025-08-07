import 'package:flutter/material.dart';

class SheetHolder extends StatelessWidget {
  const SheetHolder({super.key});

  @override
  Widget build(BuildContext context) {
    Color _color1 = Colors.brown.shade700;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            color: _color1,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: 4,
          width: 150,
        ),
      ),
    );
  }
}
