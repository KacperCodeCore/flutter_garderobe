import 'package:flutter/material.dart';

class RenameBottomSheet extends StatelessWidget {
  final String name;
  final Function(String) onSave;

  const RenameBottomSheet({
    required this.name,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _textController =
    TextEditingController(text: name);

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width, // Set the width
      child: TextField(),
    );
  }
}
