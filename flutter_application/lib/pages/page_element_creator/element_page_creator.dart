import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/widget/custom_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ElementPgeCreator extends StatefulWidget {
  const ElementPgeCreator({Key? key}) : super(key: key);

  @override
  State<ElementPgeCreator> createState() => _ElementPgeCreatorState();
}

class _ElementPgeCreatorState extends State<ElementPgeCreator> {
  File? _image;

  Future getImage(imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image == null) return;
    _image = null;
    // final imageTemporary = File(image.path);
    setState(() {
      this._image = File(image.path);
    });
    _cropImage();
  }

  Future _cropImage() async {
    File? cropperFile =
        await ImageCropper().cropImage(sourcePath: _image!.path) as File?;
    setState(() {
      this._image = cropperFile != null ? File(cropperFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Create Element"),
            Row(
              children: [
                Icon(Icons.abc),
                Icon(Icons.abc),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    height: 400,
                  )
                : Image.network(
                    'https://i.ytimg.com/vi/3xlREA-SL_k/maxresdefault.jpg'),
            CustomButton(
              title: 'Pick from camera',
              icon: Icons.camera,
              onClick: () => getImage(ImageSource.camera),
            ),
            CustomButton(
                title: 'Pick from gallery',
                icon: Icons.image_outlined,
                onClick: () => getImage(ImageSource.gallery)),
            CustomButton(
              title: "Save element",
              icon: Icons.save,
              onClick: () {
                // ElementList(elementList: );
              },
            )
          ],
        ),
      ),
    );
  }
}
