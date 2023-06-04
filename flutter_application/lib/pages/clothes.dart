import 'package:flutter/material.dart';
import 'package:flutter_application/pages/user_element.dart';

class UserClothes extends StatelessWidget {
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
            children: [UserElement(), UserElement()],
          ),
        ));
  }
}
