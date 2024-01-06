import 'package:flutter/material.dart';

class PostFooter extends StatelessWidget {
  final bool likeIt;
  final VoidCallback onLikeItPress;
  final VoidCallback onCommentPress;
  final VoidCallback onEditPress;

  const PostFooter({
    super.key,
    required this.likeIt,
    required this.onLikeItPress,
    required this.onCommentPress,
    required this.onEditPress,
  });

  @override
  Widget build(BuildContext context) {
    Color _color1 = Colors.brown.shade200;
    Color _colorLikeIt = Colors.brown.shade200;
    Color _colorLikeItOff = Colors.brown.shade800;
    Shadow _shadow1 = BoxShadow(
      color: Colors.black.withOpacity(0.6),
      spreadRadius: 5,
      blurRadius: 20,
      offset: Offset(0, 2),
    );

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
                  // size: 30,
                  color: likeIt ? _colorLikeIt : _colorLikeItOff,
                  shadows: [if (likeIt) _shadow1],
                ),
              ),
              IconButton(
                onPressed: onCommentPress,
                icon: Icon(
                  Icons.comment,
                  // size: 30,
                  color: _color1,
                  shadows: [_shadow1],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: onEditPress,
            icon: Icon(
              Icons.edit,
              size: 30,
              color: _color1,
              shadows: [_shadow1],
            ),
          ),
        ),
      ],
    );
  }
}
