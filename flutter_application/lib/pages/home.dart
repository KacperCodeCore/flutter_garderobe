import 'package:flutter/material.dart';
import 'package:flutter_application/pages/element/element_page.dart';

import 'package:flutter_application/pages/home/home_page.dart';

import 'colection/colection_page.dart';

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
      ColectionPage(),
      ElementPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double _iconSize = 35;
    Color _iconColor = Colors.brown.shade300;
    Color _selectedIconColor = Colors.brown.shade600;

    return Scaffold(
      extendBody: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.brown[200],
          borderRadius: BorderRadius.all(Radius.circular(28)),
          border: Border.all(
            color: _selectedIconColor,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(0);
                },
                child: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? _selectedIconColor : _iconColor,
                  size: _iconSize,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(1);
                },
                child: Icon(
                  Icons.collections,
                  color: _selectedIndex == 1 ? _selectedIconColor : _iconColor,
                  size: _iconSize,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(2);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: _selectedIndex == 2 ? _selectedIconColor : _iconColor,
                  size: _iconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
