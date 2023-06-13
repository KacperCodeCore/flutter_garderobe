import 'package:flutter/material.dart';
import 'package:flutter_application/pages/page_element/element.dart'
    as MyElement;
import 'package:flutter_application/pages/page_element/element_list.dart';

// import 'package:flutter_application/Images/garderobe_background.png' as backround;

class ElementPageList extends StatelessWidget {
  final ElementList elementList = ElementList(elementList: []);

  ElementPage() {
    elementList.addElement(MyElement.Element());
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
              return elementList.elementList[index];
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // elementList.addElement(MyElement.Element());
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // child: ElementPageCreator(),
                    ),
                  );
                });
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }
}
