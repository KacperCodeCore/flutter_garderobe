import 'package:flutter/material.dart';
import 'package:flutter_application/data/list_manager.dart';
// import 'package:flutter_application/pages/page_element_creator/element_heroe_creator.dart';

import '../element_creator/element_heroe_creator.dart';

// import 'package:flutter_application/Images/garderobe_background.png' as backround;

class ElementPageList extends StatelessWidget {
  final ListManager<Image> elementList;
  final void Function(Image) addElementCallback;
  final void Function(int, Image) editElementCallback;

  ElementPageList({
    required this.elementList,
    required this.addElementCallback,
    required this.editElementCallback,
  });

  int getListLastIndex() {
    return elementList.elementList.length - 1;
  }

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
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.brown,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(image: elementList.elementList[index].image),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ElementHeroeCreator(
                          index: index,
                          image: elementList.elementList[index],
                          editElementCallback: editElementCallback,
                          // delete widget after leave
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //! ? why it dont use setState from PageHome?
            addElementCallback(Image.network(
                'https://i.ytimg.com/vi/3xlREA-SL_k/maxresdefault.jpg'));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ElementHeroeCreator(
                  index: getListLastIndex(),
                  image: elementList.elementList[getListLastIndex()],
                  editElementCallback: editElementCallback,
                  // delete widget after leave
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ));
  }
}
