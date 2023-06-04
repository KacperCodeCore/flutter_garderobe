import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserElement extends StatefulWidget {
  const UserElement({super.key});

  @override
  State<UserElement> createState() => _UserElementState();
}

class _UserElementState extends State<UserElement> {
  File? _image;

  Future getImage(imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _image != null
              ? Image.file(
                  _image!,
                  height: 250,
                )
              : Image.network(
                  'https://i.ytimg.com/vi/3xlREA-SL_k/maxresdefault.jpg'),
          CustomButton(
            title: 'Pick from camera',
            icon: Icons.camera,
            onClick: () => getImage(ImageSource.gallery),
          ),
          CustomButton(
              title: 'Pick from gallery',
              icon: Icons.image_outlined,
              onClick: () => getImage(ImageSource.gallery)),
        ],
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20),
          Text(title),
        ],
      ),
    ),
  );
}
