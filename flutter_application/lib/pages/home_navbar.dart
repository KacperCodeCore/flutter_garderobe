import 'package:flutter/material.dart';
import 'package:flutter_application/data/application_data.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/pages/element/element_page.dart';

import 'package:flutter_application/pages/home/user_home_page.dart';

import 'colection/colection_page.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  var appData = Boxes.getAppData().get('appData') ?? ApplicationData();

  late int _collectionInitialIndex = 0;
  int _pageIndex = 0;

  late List<Widget> _children = [
    UserHome(
      onEditPress: (index) {
        _onEditPress(index);
      },
    ),
    ColectionPage(
      collectionInitialIndex:
          Boxes.getAppData().get('appDataKey')!.colectionIndex,
    ),
    ElementPage(),
  ];

  @override
  void initState() {
    super.initState();

    if (Boxes.getAppData().containsKey('appDataKey')) {
      _collectionInitialIndex =
          Boxes.getAppData().get('appDataKey')!.colectionIndex;
    } else {
      Boxes.getAppData().put('appDataKey', ApplicationData(colectionIndex: 0));
    }
  }

  void _onEditPress(int index) async {
    await _updateColectionPage(index);
    _navigateBottonNavBar(1);
  }

  Future<void> _updateColectionPage(int index) async {
    Boxes.getAppData()
        .put('appDataKey', ApplicationData(colectionIndex: index));
  }

  void _navigateBottonNavBar(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _iconSize = 35;
    Color _iconColor = Colors.brown.shade300;
    Color _selectedIconColor = Colors.brown.shade600;

    return Scaffold(
      extendBody: true,
      body: _children[_pageIndex],
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
                  color: _pageIndex == 0 ? _selectedIconColor : _iconColor,
                  size: _iconSize,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(1);
                },
                child: Icon(
                  Icons.collections,
                  color: _pageIndex == 1 ? _selectedIconColor : _iconColor,
                  size: _iconSize,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateBottonNavBar(2);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: _pageIndex == 2 ? _selectedIconColor : _iconColor,
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
