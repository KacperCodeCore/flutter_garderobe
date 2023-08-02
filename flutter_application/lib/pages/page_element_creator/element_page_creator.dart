import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/list_manager.dart';
import 'package:flutter_application/image_picker_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ElementPgeCreator extends StatefulWidget {
  final ListManager<Image> elementList;
  final void Function(Image) addElementCallback;

  ElementPgeCreator({
    required this.elementList,
    required this.addElementCallback,
  });

  @override
  State<ElementPgeCreator> createState() => _ElementPgeCreatorState();
}

class _ElementPgeCreatorState extends State<ElementPgeCreator> {
  File? _image;

  Future _getImage(imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image == null) return;
    _image = null;
    // final imageTemporary = File(image.path);
    setState(() {
      this._image = File(image.path);
    });
  }

  // Future _croppImage() async {
  //   try {
  //     File? cropperFile =
  //         await ImageCropper().cropImage(sourcePath: _image!.path) as File?;
  //     setState(() {
  //       this._image = cropperFile != null ? File(cropperFile.path) : null;
  //     });
  //   } catch (e) {}
  // }

  // Future _croppImage() async {
  //   try {
  //     if (_image != null) {
  //       final croppedFile = await ImageCropper().cropImage(
  //         sourcePath: _image!.path,
  //         aspectRatioPresets: [
  //           CropAspectRatioPreset.square,
  //           CropAspectRatioPreset.ratio3x2,
  //           CropAspectRatioPreset.original,
  //           CropAspectRatioPreset.ratio4x3,
  //           CropAspectRatioPreset.ratio16x9,
  //         ],
  //         uiSettings: [
  //           AndroidUiSettings(
  //               toolbarTitle: 'Cropper',
  //               toolbarColor: Colors.deepOrange,
  //               toolbarWidgetColor: Colors.white,
  //               initAspectRatio: CropAspectRatioPreset.original,
  //               lockAspectRatio: false),
  //           IOSUiSettings(
  //             title: 'Cropper',
  //           ),
  //           WebUiSettings(
  //             context: context,
  //           ),
  //         ],
  //       );
  //       setState(() {
  //         this._image = croppedFile != null ? File(croppedFile.path) : null;
  //       });
  //     }

  //     // Tutaj możesz obsłużyć przycięty plik obrazu
  //   } catch (e) {
  //     // Tutaj możesz obsłużyć błędy
  //   }
  // }

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
        child: _image != null
            ? Image.file(
                _image!,
                height: 400,
              )
            : Image.network(
                'https://i.ytimg.com/vi/3xlREA-SL_k/maxresdefault.jpg'),
        // child: Column(
        //   children: [
        //     _image != null
        //         ? Image.file(
        //             _image!,
        //             height: 400,
        //           )
        //         : Image.network(
        //             'https://i.ytimg.com/vi/3xlREA-SL_k/maxresdefault.jpg'),
        //     CustomButton(
        //       title: 'Pick from camera',
        //       icon: Icons.camera,
        //       onClick: () => _getImage(ImageSource.camera),
        //     ),
        //     CustomButton(
        //         title: 'Pick from gallery',
        //         icon: Icons.image_outlined,
        //         onClick: () => _getImage(ImageSource.gallery)),
        //     CustomButton(
        //         title: 'image cropper',
        //         icon: Icons.image_outlined,
        //         onClick: () async => {
        //               ImagePickerService().pickCropImage(
        //                 cropAspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        //                 imageSource: ImageSource.camera,
        //               )
        //             }), //_croppImage
        //     CustomButton(
        //       title: "Save element",
        //       icon: Icons.save,
        //       onClick: () {
        //         widget.addElementCallback(Image.file(_image!));
        //       },
        //     )
        //   ],
        // ),
      ),
      floatingActionButton: Column(
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.camera),
            child: Icon(Icons.camera),
          ),
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.gallery),
            child: Icon(Icons.photo_library_outlined),
          ),
          FloatingActionButton(
            onPressed: () async => {
              ImagePickerService().pickCropImage(
                cropAspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                imageSource: ImageSource.camera,
              )
            },
            child: Icon(Icons.image),
          ),
          FloatingActionButton(
            onPressed: () => {widget.addElementCallback(Image.file(_image!))},
            child: Icon(Icons.save),
          ),
          FloatingActionButton(
            onPressed: () => {widget.addElementCallback(Image.file(_image!))},
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
