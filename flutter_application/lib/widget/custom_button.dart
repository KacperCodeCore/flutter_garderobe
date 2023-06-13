import 'package:flutter/material.dart';

Widget CustomButton({
  required IconData icon,
  required String title,
  required VoidCallback onClick,
}) {
  return Container(
    width: 230,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20),
          Text(title),
        ],
      ),
    ),
  );
}
