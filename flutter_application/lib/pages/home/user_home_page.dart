import 'package:flutter/material.dart';

import '../../assets/widgets/sheet_holder.dart';

import '../../data/boxes.dart';
import '../../data/collection.dart';
import 'user_post.dart';

class UserHome extends StatefulWidget {
  final Function(int) onEditPress;

  const UserHome({
    super.key,
    required this.onEditPress,
  });

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var collections = Boxes.getCollection().values.toList().cast<Collection>();

  final TextEditingController _textController = TextEditingController();

  void _showBottomSheet(int index, Collection collection) async {
    _textController.text = collection.comment;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        double bottomSheetHeight = keyboardHeight + 300;

        return Container(
          height: bottomSheetHeight,
          child: Column(
            children: [
              SheetHolder(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    controller: _textController,
                    style: TextStyle(),
                    decoration: InputDecoration(hintText: 'Comment'),
                    maxLines: null,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.save_alt_rounded,
                  size: 40,
                ),
                onPressed: () {
                  collection.comment = _textController.text;
                  _updateCollection(index, collection);
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: keyboardHeight),
            ],
          ),
        );
      },
    );
  }

  void _updateCollection(int index, Collection collection) async {
    Boxes.getCollection().putAt(index, collection);
    setState(() {
      collections = Boxes.getCollection().values.toList();
    });
  }

  void _onLikeItPress(int index, Collection collection) async {
    collection.likeIt = !collection.likeIt;

    Boxes.getCollection().putAt(index, collection);
    setState(() {
      collections = Boxes.getCollection().values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          return UserPost(
            name: collections[index].name,
            path: collections[index].screenshotPath,
            likeIt: collections[index].likeIt,
            onLikeItPress: () => _onLikeItPress(index, collections[index]),
            onCommentPress: () => _showBottomSheet(index, collections[index]),
            onEditPress: () {
              widget.onEditPress(index);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
