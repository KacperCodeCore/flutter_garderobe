import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import 'package:flutter_application/data/my_element.dart';
import '../../../assets/widgets/sheet_holder.dart';

class ElementBottomSheet extends StatefulWidget {
  final MyElement? myElement;
  final Function(MyElement) add;
  final Function(MyElement) update;

  ElementBottomSheet({
    this.myElement,
    super.key,
    required this.add,
    required this.update,
  });

  @override
  State<ElementBottomSheet> createState() => _ElementBottomSheetState();
}

class _ElementBottomSheetState extends State<ElementBottomSheet> {
  late MyElement _myElement;

  @override
  void initState() {
    if (widget.myElement == null) {
      _myElement = MyElement(
          name: 'name',
          path: 'images/null.png',
          height: 100,
          width: 100,
          type: ClotherType.none);
    } else {
      _myElement = widget.myElement!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SheetHolder(),
        Image.asset('lib/assets/images/null.png'),

        // Image.file(File(
        //     'D:\\GitHub\\Flutter\\flutter_garderobe\\flutter_application\\lib\\assets\\images\\null.png')),

        // Image.file(File(_myElement.path)),
        Image.file(File('${Boxes.appDir}/null.png')),
        Container(
          height: 800,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                widget.add(_myElement);
              },
            ),
          ],
        )
      ],
    );
  }
}
