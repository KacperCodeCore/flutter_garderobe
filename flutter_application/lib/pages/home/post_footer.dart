import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final bool likeIt;
  final VoidCallback onLikeItPress;
  final VoidCallback onCommentPress;
  final VoidCallback comment;
  final VoidCallback edit;

  const PostFooter({
    super.key,
    required this.comment,
    required this.likeIt,
    required this.edit,
    required this.onLikeItPress,
    required this.onCommentPress,
  });

  @override
  Widget build(BuildContext context) {
    Color _color1 = Colors.brown.shade800;
    Color _colorLikeIt = Colors.red;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: onLikeItPress,
                icon: Icon(
                  Icons.favorite,
                  size: 30,
                  color: likeIt ? _colorLikeIt : _color1,
                ),
              ),
              IconButton(
                onPressed: onCommentPress,
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
