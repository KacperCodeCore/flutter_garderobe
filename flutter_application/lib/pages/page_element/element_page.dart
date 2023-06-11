import 'package:flutter/material.dart';
import 'package:flutter_application/pages/page_element/element.dart'
    as MyElement;
import 'package:flutter_application/pages/page_element/element_list.dart';

class ElementPage extends StatelessWidget {
  final ElementList elementList = ElementList(elementList: []);

  ElementPage() {
    elementList.addElement(MyElement.Element());
    elementList.addElement(MyElement.Element());
    elementList.addElement(MyElement.Element());
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
      body: ListView.builder(
        itemCount: elementList.elementList.length,
        itemBuilder: (BuildContext context, int index) {
          return elementList.elementList[index];
        },
      ),
    );
  }
}
