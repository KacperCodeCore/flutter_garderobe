import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/home/bottom_post_sheet.dart';

class UserPost extends StatelessWidget {
  final String name;
  final String? path;
  final bool likeIt;
  final VoidCallback onLikeItPress;
  final VoidCallback onCommentPress;
  final VoidCallback onEditPress;

  UserPost({
    required this.name,
    required this.path,
    required this.onLikeItPress,
    required this.likeIt,
    required this.onCommentPress,
    required this.onEditPress,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // post
        Container(
          height: 630,
          child: path != null ? Image.file(File(path!)) : null,
        ),
        // padding
        PostFooter(
          likeIt: likeIt,
          onLikeItPress: onLikeItPress,
          onCommentPress: onCommentPress,
          onEditPress: onEditPress,
        )
      ],
    );
  }
}
