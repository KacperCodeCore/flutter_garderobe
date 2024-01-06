import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import '../../../assets/widgets/sheet_holder.dart';

import '../../data/my_element.dart';

class ColectionBottomSheet extends StatefulWidget {
  final Function(MyElement) onTap;
  final Map<ClotherType, List<MyElement>> groupedElements;

  ColectionBottomSheet({
    required this.onTap,
    super.key,
    required this.groupedElements,
  });

  @override
  State<ColectionBottomSheet> createState() => _ColectionBottomSheetState();
}

class _ColectionBottomSheetState extends State<ColectionBottomSheet> {
  double _height = 100;
  double _fullHight = 100;

  @override
  void initState() {
    _fullHight = _height * widget.groupedElements.length.toDouble() + 60;
    _fullHight > 400 ? 400 : _fullHight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _fullHight,
      child: Column(
        children: [
          SheetHolder(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.groupedElements.length,
              itemBuilder: (BuildContext context, int typeIndex) {
                var type = widget.groupedElements.keys.toList()[typeIndex];

                return SizedBox(
                  height: _height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.groupedElements[type]!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var element = widget.groupedElements[type]![index];
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
