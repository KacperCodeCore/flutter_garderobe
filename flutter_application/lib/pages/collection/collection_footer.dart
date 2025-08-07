import 'package:flutter/material.dart';

class CollectionFooter extends StatelessWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final VoidCallback addPage;
  final VoidCallback deletePage;
  final VoidCallback rename;

  const CollectionFooter({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.deletePage,
    required this.addPage,
    required this.rename,
  });

  @override
  Widget build(BuildContext context) {
    Color _color1 = Colors.brown.shade800;
    Shadow _shadow1 = BoxShadow(
        // color: Colors.black.withOpacity(0.6),
        // spreadRadius: 5,
        // blurRadius: 20,
        // offset: Offset(0, 2),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: previousPage,
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: _color1,
                  shadows: [_shadow1],
                ),
              ),
              IconButton(
                onPressed: nextPage,
                icon: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: _color1,
                  shadows: [_shadow1],
                ),
              ),
              IconButton(
                onPressed: addPage,
                icon: Icon(
                  Icons.add_photo_alternate_rounded,
                  color: _color1,
                  shadows: [_shadow1],
                ),
              ),
              IconButton(
                onPressed: deletePage,
                icon: Icon(
                  Icons.delete_forever,
                  color: _color1,
                  shadows: [_shadow1],
                ),
              ),
              IconButton(
                onPressed: rename,
                icon: Icon(
                  Icons.drive_file_rename_outline_outlined,
                  color: _color1,
                  shadows: [_shadow1],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
