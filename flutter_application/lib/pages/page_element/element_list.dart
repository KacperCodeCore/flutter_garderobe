import 'package:flutter/material.dart';

class ElementList {
  List<Widget> elementList;

  ElementList({required this.elementList});

  void addElement(Widget element) {
    elementList.add(element);
  }

  void removeElement(Widget element) {
    elementList.remove(element);
  }
}
