import 'package:flutter/material.dart';
import 'package:flutter_application/pages/element/widgets/element.dart'
    as MyElement;
import 'package:flutter_application/pages/element/widgets/element_list.dart';
// import 'package:flutter_application/Images/garderobe_background.png' as backround;

class ElementPage extends StatelessWidget {
  final ElementList elementList = ElementList(elementList: []);

  ElementPage() {
    elementList.addElement(MyElement.Element());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            elementList.addElement(MyElement.Element());
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ));
  }
}
