import 'package:flutter/material.dart';
import 'package:flutter_application/pages/element_star/element_page.dart';

import 'package:flutter_application/pages/home/homepage.dart';

import 'collection/collection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<Widget> _children;

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
      ElementPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5, left: 2, right: 2),
        child: ClipRRect(
          // decoration: const BoxDecoration(
          //   color: Colors.brown,
          //   borderRadius: BorderRadius.all(Radius.circular(30)),
          // ),

          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottonNavBar,
            // elevation: 10,

            backgroundColor: Colors.brown,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.collections), label: 'Collection'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_a_photo_outlined),
                  label: 'Create Element'),
            ],
          ),
        ),
      ),
    );
  }
}
