import 'package:flutter/material.dart';

class ColectionFooter extends StatelessWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final VoidCallback addPage;
  final VoidCallback deletePage;

  const ColectionFooter({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.deletePage,
    required this.addPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              IconButton(
                onPressed: previousPage,
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: nextPage,
                icon: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: addPage,
                icon: Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: deletePage,
                icon: Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
