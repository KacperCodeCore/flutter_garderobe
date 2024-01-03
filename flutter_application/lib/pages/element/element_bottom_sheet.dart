import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import 'package:flutter_application/data/my_element.dart';

import 'package:image_picker/image_picker.dart';
import '../../../assets/widgets/sheet_holder.dart';

class ElementBottomSheet extends StatefulWidget {
  final MyElement? myElement;
  final bool isEdited;
  final Function(MyElement) add;
  final Function(MyElement) update;
  final Function(MyElement) delete;

  ElementBottomSheet({
    this.myElement,
    super.key,
    required this.add,
    required this.update,
    required this.delete,
    required this.isEdited,
  });

  @override
  State<ElementBottomSheet> createState() => _ElementBottomSheetState();
}

const double iconSize = 40;

class _ElementBottomSheetState extends State<ElementBottomSheet> {
  final String _nullPath = '${Boxes.appDir}/null.png';
  late TextEditingController _textController;
  late MyElement _myElement;

  @override
  void initState() {
    if (widget.myElement == null) {
      _myElement = MyElement(
          name: 'name',
          path: _nullPath,
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
      // backgroundColor: Colors.brown.shade400,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 125,
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
        );
      },
    );
  }

  void _showBottomSheetEnums(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              // color: Colors.blue[100],
              child: ListView.builder(
                controller: scrollController,
                itemCount: ClotherType.values.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.brown.shade300,
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '   ' +
                                  ClotherType.values
                                      .elementAt(index)
                                      .toString()
                                      .split('.')
                                      .last,
                              style: TextStyle(
                                  fontSize: 25, color: Colors.brown.shade900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SheetHolder(),
            //image
            if (_myElement.path != _nullPath)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: (ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 500),
                    child: Image.file(File(_myElement.path)),
                  ),
                )),
              ),
            // buttons
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                bottom: 30.0,
                right: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    onPressed: () {
                      _showBottomSheetEnums(context);
                    },
                  ),
                  //remove
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: iconSize,
                    ),
                    onPressed: () {
                      widget.delete(_myElement);
                    },
                  ),
                  // add/ update
                  IconButton(
                    icon: Icon(
                      Icons.check_box_outlined,
                      size: iconSize,
                    ),
                    onPressed: () {
                      if (widget.isEdited) {
                        widget.update(_myElement);
                      } else {
                        widget.add(_myElement);
                      }
                    },
                  ),
                  // // back
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.exit_to_app_rounded,
                  //     size: iconSize,
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
