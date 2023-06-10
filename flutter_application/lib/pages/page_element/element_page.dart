import 'package:flutter/material.dart';
import 'package:flutter_application/pages/page_element/element.dart'
    as MyElement;

class ElementPage extends StatelessWidget {
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
          child: Column(
            children: [MyElement.Element(), MyElement.Element()],
          ),
        ));
  }
}
