import 'package:flutter/material.dart';

class RenameAlertDialog extends StatelessWidget {
  final String name;

  final Function(String) onSave;

  const RenameAlertDialog({
    Key? key,
    required this.name,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController =
        TextEditingController(text: name);

    return Column(
      children: [
        Container(
          height: 400,
        )
      ],
    );
    // return AlertDialog(
    //   insetPadding: const EdgeInsets.all(2),
    //   content: SizedBox(
    //     height: 100,
    //     width: MediaQuery.of(context).size.width, // Set the width
    //     child: TextField(),
    //   ),
    // );
  }
}
