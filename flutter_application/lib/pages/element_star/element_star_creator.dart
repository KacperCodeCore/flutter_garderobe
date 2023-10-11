import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ElementStarCreator extends StatefulWidget {
  final String name;
  final String imagePath;
  final Function(String, String) onSave;
  final Function() onDelete;

  ElementStarCreator({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.onSave,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ElementStarCreator> createState() => _ElementStarCreatorState();
}

class _ElementStarCreatorState extends State<ElementStarCreator> {
  late TextEditingController _controller;
  late String _imagePath = widget.imagePath;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.name);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star Edit')),
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          TextField(controller: _controller),
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
                widget.onSave(_controller.text, _imagePath);
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
  //git test