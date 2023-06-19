import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/widget/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class ElementHeroeCreator extends StatefulWidget {
  final int index;
  final Image image;
  final void Function(int, Image) editElementCallback;
  // final void Function() setStateCallback;
  // final void Function() addElementCallback;

  const ElementHeroeCreator({
    required this.index,
    required this.image,
    required this.editElementCallback,
    // required this.setStateCallback,
    // required this.addElementCallback,
  });

  @override
  State<ElementHeroeCreator> createState() => _ElementHeroeCreatorState();
}

class _ElementHeroeCreatorState extends State<ElementHeroeCreator> {
  late ImageProvider<Object> _image;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _image = widget.image.image;
  }

  Future getImage(imageSource) async {
    final imageSorce = await ImagePicker().pickImage(source: imageSource);
    if (imageSorce == null) return;
    _imageFile = null;
    // final imageTemporary = File(image.path);
    setState(() {
      this._imageFile = File(imageSorce.path);
    });
  }

  @override
  void dispose() {
    // widget.setStateCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: _image),
          Column(children: [
            CustomButton(icon: Icons.camera, title: "Camera", onClick: () {}),
            CustomButton(icon: Icons.photo, title: "Photo", onClick: () {}),
            CustomButton(icon: Icons.photo, title: "Edit", onClick: () {}),
            CustomButton(icon: Icons.photo, title: "Delete", onClick: () {}),
            CustomButton(icon: Icons.photo, title: "Save", onClick: () {}),
          ])
        ],
      )),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //       icon: Icon(Icons.camera),
      //       icon: Icon(Icons.photo),
      //       icon: Icon(Icons.save),
      //     ]
      // )
    );
  }
}
