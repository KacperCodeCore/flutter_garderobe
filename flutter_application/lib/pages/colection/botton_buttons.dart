import 'package:flutter/material.dart';

class BottonButtons extends StatelessWidget {
  final void Function() onDelete;

  const BottonButtons({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.brown.shade400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 30),
          Icon(
            Icons.add_to_photos_rounded,
            size: 30,
            color: Colors.brown,
          ),
          SizedBox(width: 30),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_forever,
              size: 30,
              color: Colors.brown,
            ),
          )
        ],
      ),
    );
  }
}
