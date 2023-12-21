import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/clother_type_adapter.dart';

class ElementCreator extends StatefulWidget {
  final String name;
  final String imagePath;
  final double height;
  final double width;
  final ClotherType type;
  final Function(String, String, double, double, ClotherType) onSave;
  final Function() onDelete;

  ElementCreator({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.type,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ElementCreator> createState() => _ElementCreatorState();
}

class _ElementCreatorState extends State<ElementCreator> {
  late TextEditingController _controller;
  late String _imagePath = widget.imagePath;
  late double _height = widget.height;
  late double _width;
  late ClotherType _type = widget.type;

  @override
  void initState() {
    _controller = TextEditingController(text: '$widget.name $_height');
    _imagePath = widget.imagePath;
    _height = widget.height;
    _type = widget.type;
    super.initState();
  }

  Future<void> _choseImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: source);
    if (image == null) return;

    File imageFile = File(image.path);
    if (imageFile.existsSync()) {
      if (mounted) {}

      setState(() {
        _imagePath = image.path;
      });
      _getPictureHeight();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getPictureHeight() async {
    if (!File(_imagePath).existsSync()) return;

    File image = new File(_imagePath);
    var decodeImage = await decodeImageFromList(image.readAsBytesSync());

    final height = decodeImage.height.toDouble();
    final width = decodeImage.width.toDouble();
    final scale = height / width;
    final screenWidth = MediaQuery.of(context).size.width;

    setState(() {
      _height = screenWidth * scale;
      _width = width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          File(_imagePath).existsSync()
              ? Image.file(
                  File(
                    _imagePath,
                  ),
                  fit: BoxFit.fitWidth)
              : Icon(Icons.not_accessible),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // type1
            FloatingActionButton.extended(
              heroTag: 'type1',
              onPressed: () {
                _type = ClotherType.dress;
              },
              label: Text(''),
              icon: Icon(Icons.change_circle),
            ),
            //type2
            FloatingActionButton.extended(
              heroTag: 'type2',
              onPressed: () {
                _type = ClotherType.hat;
              },
              label: Text(''),
              icon: Icon(Icons.change_circle_outlined),
            ),
            // camera button
            FloatingActionButton.extended(
              heroTag: 'takePicture',
              onPressed: () {
                _choseImage(ImageSource.camera);
              },
              label: Text('Take photo'),
              icon: Icon(Icons.add_a_photo),
            ),
            // gallery button
            FloatingActionButton.extended(
              heroTag: 'tagChoseFromGallery',
              onPressed: () {
                _choseImage(ImageSource.gallery);
              },
              icon: Icon(Icons.save),
              label: Text('Chose from gallery'),
            ),
            //delete button
            FloatingActionButton.extended(
              heroTag: 'TagDeletePicture',
              backgroundColor: Colors.blue,
              onPressed: () {
                widget.onDelete();
                Navigator.of(context).pop(); //good
              },
              icon: Icon(Icons.delete),
              label: Text('Delete'),
            ),
            //save button
            FloatingActionButton.extended(
              heroTag: 'TagSavePicture',
              backgroundColor: Colors.blue,
              onPressed: () {
                widget.onSave(
                    _controller.text, _imagePath, _height, _width, _type);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save),
              label: Text('Save'),
            ),
            //exit button
            FloatingActionButton.extended(
              heroTag: 'TagExitCreator',
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: null,
              label: Text('x'),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
