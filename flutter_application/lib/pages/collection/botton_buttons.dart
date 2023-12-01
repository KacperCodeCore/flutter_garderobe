import 'package:flutter/material.dart';

class BottonButtons extends StatelessWidget {
  const BottonButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.brown.shade400,
      child: const Row(
        children: [
          Icon(
            Icons.abc,
            size: 30,
          ),
          Icon(Icons.abc),
        ],
      ),
    );
  }
}
