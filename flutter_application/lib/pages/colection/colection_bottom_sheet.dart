import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import '../../../assets/widgets/sheet_holder.dart';

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
  // Color _color1 = Colors.brown.shade600;
  double _height = 100;
  double _fullHight = 100;
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var uniquetype =
      Boxes.getMyElements().values.map((element) => element.type).toSet();
  Map<ClotherType, List<MyElement>> groupedElements = {};

  @override
  void initState() {
    for (ClotherType type in uniquetype)
      groupedElements[type] =
          elements.where((element) => element.type == type).toList();

    _fullHight = _height * groupedElements.length.toDouble() + 60;
    _fullHight > 400 ? 400 : _fullHight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _fullHight,
      // color: Colors.brown.shade900,
      child: Column(
        children: [
          SheetHolder(),
          Expanded(
            child: ListView.builder(
              itemCount: groupedElements.length,
              itemBuilder: (BuildContext context, int typeIndex) {
                var type = groupedElements.keys.toList()[typeIndex];

                return SizedBox(
                  height: _height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: groupedElements[type]!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var element = groupedElements[type]![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 10),
                        child: SizedBox(
                          height: _height - 10,
                          width: _height - 10,
                          child: GestureDetector(
                            onTap: () {
                              widget.onTap(element);
                            },
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
