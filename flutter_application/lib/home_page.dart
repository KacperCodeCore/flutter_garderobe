import 'package:flutter/material.dart';
import 'package:flutter_application/data/list_manager.dart';
import 'package:flutter_application/pages/page_collection/collection_page.dart';
import 'package:flutter_application/pages/page_element_creator/element_page_creator.dart';
import 'package:flutter_application/pages/page_element/element_page_list.dart';
import 'package:flutter_application/pages/page_home/home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListManager<Image> elementList = ListManager<Image>();
  ListManager<Widget> collectionList = ListManager<Widget>();
  late List<Widget> _children;

  void addElement(Image image) {
    setState(() {
      elementList.addElement(image);
    });
  }

  void editElement(int index, Image newElement) {
    if (index >= 0 && index < elementList.elementList.length) {
      elementList.elementList[index] = newElement;
    }
  }

  int _selectedIndex = 0;
  void _navigateBottonNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _children = [
      UserHome(),
      CollectionPage(),
      ElementPageList(
        elementList: elementList,
        addElementCallback: addElement,
        editElementCallback: editElement,
      ),
      ElementPgeCreator(
        elementList: elementList,
        addElementCallback: addElement,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottonNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections), label: 'Collection'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Element'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo_outlined), label: 'Create Element'),
        ],
      ),
    );
  }
}
