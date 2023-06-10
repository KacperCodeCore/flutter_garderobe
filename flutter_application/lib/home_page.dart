import 'package:flutter/material.dart';
import 'package:flutter_application/pages/page_element/element_page.dart';
import 'package:flutter_application/pages/page_collection/garderobe.dart';
import 'package:flutter_application/pages/page_home/home.dart';
import 'package:flutter_application/pages/page_search/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottonNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    UserHome(),
    UserSearch(),
    CollectionPage(),
    ElementPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottonNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'sdsd'),
          BottomNavigationBarItem(
              icon: Icon(Icons.warehouse), label: 'Collection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_rounded), label: 'Clothes'),
        ],
      ),
    );
  }
}
