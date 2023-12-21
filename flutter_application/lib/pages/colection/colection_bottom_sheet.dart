import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';

import '../../data/boxes.dart';
import '../../data/my_element.dart';

class ColectionBottomSheet extends StatefulWidget {
  final Function(MyElement) onTap;

  ColectionBottomSheet({
    required this.onTap,
    super.key,
  });

  @override
  State<ColectionBottomSheet> createState() => _ColectionBottomSheetState();
}

class _ColectionBottomSheetState extends State<ColectionBottomSheet> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var uniquetype =
      Boxes.getMyElements().values.map((element) => element.type).toSet();
  Map<ClotherType, List<MyElement>> groupedElements = {};

  @override
  void initState() {
    for (ClotherType type in uniquetype)
      groupedElements[type] =
          elements.where((element) => element.type == type).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown.shade900,
      child: Column(children: [
        for (var type in groupedElements.keys)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupedElements[type]!.length,
              itemBuilder: (BuildContext context, int index) {
                var element = groupedElements[type]![index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: GestureDetector(
                      onTap: () {
                        widget.onTap(element);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.file(
                          File(element.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ]),
    );
  }
}
