import 'package:flutter/material.dart';

import '../../assets/widgets/sheet_holder.dart';

class RenameBottomSheet extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) updateCollection;
  final String initialName;

  RenameBottomSheet({
    Key? key,
    required this.textController,
    required this.updateCollection,
    required this.initialName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double bottomSheetHeight = keyboardHeight + 150;

    return Container(
      height: bottomSheetHeight,
      child: Column(
        children: [
          SheetHolder(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                  controller: textController,
                  style: TextStyle(),
                  decoration: InputDecoration(hintText: 'Collection Name'),
                  maxLines: 1,
                  maxLength: 16,
                  textAlignVertical: TextAlignVertical.center),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.save_alt_rounded,
              size: 40,
            ),
            onPressed: () {
              updateCollection(textController.text);
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: keyboardHeight),
        ],
      ),
    );
  }
}
