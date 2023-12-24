import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/element/element_bottom_sheet_image.dart';
import 'package:image_picker/image_picker.dart';
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

const double iconSize = 40;

class _ElementBottomSheetState extends State<ElementBottomSheet> {
  late TextEditingController _textController;
  late MyElement _myElement;

  @override
  void initState() {
    if (widget.myElement == null) {
      _myElement = MyElement(
          name: 'name',
          path: '${Boxes.appDir}/null.png',
          height: 200,
          width: 200,
          type: ClotherType.none);
    } else {
      _myElement = widget.myElement!;
    }

    _textController = TextEditingController(text: '$_myElement.name');

    super.initState();
  }

  Future<void> _choseImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: source);
    if (image == null) return;

    File imageFile = File(image.path);
    if (imageFile.existsSync()) {
      if (mounted) {}

      _myElement.path = image.path;
      //todo usunąć setstete
      setState(() {
        _setPictureSize();
      });
    }
  }

  void _setPictureSize() async {
    if (!File(_myElement.path).existsSync()) return;

    File image = new File(_myElement.path);
    var decodeImage = await decodeImageFromList(image.readAsBytesSync());

    final height = decodeImage.height.toDouble();
    final width = decodeImage.width.toDouble();
    final scale = height / width;
    final screenWidth = MediaQuery.of(context).size.width;

    //todo removesetstate
    setState(() {
      _myElement.height = screenWidth * scale;
      _myElement.width = screenWidth;
    });
  }

  void _showBottomSheetImage() {
    showModalBottomSheet(
      backgroundColor: Colors.brown.shade400,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: iconSize,
                  ),
                  onPressed: () {
                    _choseImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: iconSize,
                  ),
                  onPressed: () {
                    _choseImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SheetHolder(),
          Image.file(File(_myElement.path)),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   icon: Icon(
                //     Icons.add,
                //     size: iconSize,
                //   ),
                //   onPressed: () {
                //     widget.add(_myElement);
                //   },
                // ),
                // IconButton(
                //   icon: Icon(
                //     Icons.add,
                //     size: iconSize,
                //   ),
                //   onPressed: () {
                //     widget.add(_myElement);
                //   },
                // ),

                //_choseImage
                IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: iconSize,
                  ),
                  onPressed: () {
                    _showBottomSheetImage();
                  },
                ),
                //category
                IconButton(
                  icon: Icon(
                    Icons.category_outlined,
                    size: iconSize,
                  ),
                  onPressed: () {},
                ),
                //remove
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: iconSize,
                  ),
                  onPressed: () {},
                ),
                // add
                IconButton(
                  icon: Icon(
                    Icons.check_box_outlined,
                    size: iconSize,
                  ),
                  onPressed: () {
                    widget.add(_myElement);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
