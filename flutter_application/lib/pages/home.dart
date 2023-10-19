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
    double _iconSize = 40;

    return Scaffold(
      extendBody: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10, bottom: 50, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.brown[200],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
              color: const Color.fromARGB(255, 30, 21, 17),
              width: 3,
            )),
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
                  size: _iconSize,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(1);
                },
                child: Icon(
                  Icons.collections,
                  size: _iconSize,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(2);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
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
