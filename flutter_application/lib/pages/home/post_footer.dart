import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final VoidCallback likeIt;
  final VoidCallback comment;
  final VoidCallback edit;

  const PostFooter({
    super.key,
    required this.likeIt,
    required this.comment,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    Color _color1 = Colors.brown.shade800;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: likeIt,
                icon: Icon(
                  Icons.favorite,
                  size: 30,
                  color: _color1,
                ),
              ),
              IconButton(
                onPressed: comment,
                icon: Icon(
                  Icons.comment,
                  size: 30,
                  color: _color1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: edit,
            icon: Icon(
              Icons.edit,
              size: 30,
              color: _color1,
            ),
          ),
        ),
      ],
    );
  }
}
