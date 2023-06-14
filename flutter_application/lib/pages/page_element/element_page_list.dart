import 'package:flutter/material.dart';
import 'package:flutter_application/data/list_manager.dart';

// import 'package:flutter_application/Images/garderobe_background.png' as backround;

class ElementPageList extends StatelessWidget {
  final ListManager<Image> elementList;
  final void Function(Image) addElementCallback;

  ElementPageList({
    required this.elementList,
    required this.addElementCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Clothes'),
              Row(
                children: [
                  Icon(Icons.abc),
                  Icon(Icons.abc),
                ],
              ),
            ],
          ),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: elementList.elementList.length,
            itemBuilder: (BuildContext context, int index) {
              return elementList.elementList[index];
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //? why it dont use setState from PageHome?
            addElementCallback(Image.network(
                'https://i.ytimg.com/vi/3xlREA-SL_k/maxresdefault.jpg'));
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }
}
