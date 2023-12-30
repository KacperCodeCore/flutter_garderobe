import 'package:flutter/material.dart';

import '../../assets/widgets/sheet_holder.dart';
import '../../data/boxes.dart';
import '../../data/colection.dart';
import 'user_post.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var colections = Boxes.getColection().values.toList().cast<Colection>();
  final TextEditingController _textController = TextEditingController();

  void _showBottomSheet() {
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
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: TextField(
                    style: TextStyle(),
                    decoration: InputDecoration(hintText: 'Comment'),
                    // autofocus: true,
                    maxLines: null,
                  ),
                ),
              ),
              SizedBox(height: keyboardHeight),
            ],
          ),
        );
      },
    );
  }

  void _onLikeitPress(int index, Colection collection) async {
    collection.likeIt = !collection.likeIt;

    Boxes.getColection().putAt(index, collection);
    setState(() {
      colections = Boxes.getColection().values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: colections.length,
        itemBuilder: (context, index) {
          return UserPost(
            name: colections[index].name,
            path: colections[index].screenshotPath,
            likeIt: colections[index].likeIt,
            onLikeItPress: () => _onLikeitPress(index, colections[index]),
            onCommentPress: () => _showBottomSheet(),
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
