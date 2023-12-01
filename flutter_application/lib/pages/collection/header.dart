import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final int index;
  final Function(String, int) onTextChange;

  const Header({
    Key? key,
    required this.index,
    required this.onTextChange,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // lewo
          const Icon(
            Icons.chevron_left_rounded,
            size: 45,
          ),

          // Text('Collection name', style: TextStyle(fontSize: 35)),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
              controller: _controller,
              maxLength: 16,
              maxLengthEnforcement: null,
              onChanged: (text) {
                widget.onTextChange(text, widget.index);
              },
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Collection Name',
                border: InputBorder.none,
                // focusedBorder: OutlineInputBorder(
                //   gapPadding: 0.0,
                //   borderSide: BorderSide(
                //     color: Colors.brown.shade700,
                //     width: 3,
                //   ),
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                // ),
                hintStyle: TextStyle(fontSize: 30),
              ),
            ),
          ),

          //prewo
          const Icon(
            Icons.chevron_right_rounded,
            size: 45,
          ),
        ],
      ),
    );
  }
}
