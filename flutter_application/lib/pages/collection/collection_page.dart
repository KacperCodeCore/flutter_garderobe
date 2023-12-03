import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/botton_buttons.dart';
import 'package:flutter_application/pages/collection/draggable_widget.dart';
import 'package:flutter_application/pages/collection/header.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../data/boxes.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var collections = Boxes.getCollection().values.toList().cast<Collection>();
  ScreenshotController screenshotController = ScreenshotController();
  bool showButton = true;
  late StreamSubscription<bool> _keyboardVisibilitySubscription;

  @override
  void initState() {
    super.initState();

    _keyboardVisibilitySubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      setState(() {
        showHideButton(visible);
      });
    });

    if (collections.isEmpty) {
      Collection newCollection = Collection(
        name: 'name',
        elements: [],
        lastEdited: DateTime.now(),
        screenshotPath: '',
      );
      Boxes.getCollection().add(newCollection);
      setState(() {
        collections = Boxes.getCollection().values.toList();
      });
    }
  }

  void showHideButton(bool isKeyboardVisible) {
    if (isKeyboardVisible) {
      showButton = false;
    } else {
      Future.delayed(Duration(milliseconds: 400), () {
        setState(() {
          showButton = true;
        });
      });
    }
    print('showButton $showButton');
  }

  Future<void> _addElement(String name, String path) async {
    var collectionElement = CollectionElement(
      name: 'new',
      path: path,
      matrix4: Matrix4.identity(),
    );

    setState(() {
      // aktualizacjia kolekcji w Hive, aby zapisac zmiany.
      Boxes.getCollection().getAt(0)!.elements.add(collectionElement);
      // jest to konieczne, aby Hive śledził i zapisywał zmiany.
      Boxes.getCollection().putAt(0, Boxes.getCollection().getAt(0)!);
    });
  }

  Future<void> _updateCollectionElement(
      String name, String path, Matrix4 m4, int index) async {
    String? _screenshotPath = await _TakeScreenshotPath(path);

    if (_screenshotPath == null) return;
    CollectionElement element = CollectionElement(
      name: name,
      path: path,
      matrix4: m4,
    );

    Collection collection = Boxes.getCollection().getAt(0)!;
    collection.elements[index] = element;
    collection.screenshotPath = _screenshotPath;
    setState(() {
      Boxes.getCollection().putAt(0, collection);
    });
  }

  /// dodanie nowego elementu do hive
  void _deleteCollectionElement(int index) {
    // var tempElement =
    //     collection.elements.singleWhere((e) => e.id == element.id);

    setState(() {
      Boxes.getCollection().deleteAt(index);
    });
  }

  Future<String?> _TakeScreenshotPath(String oldPath) async {
    final Uint8List? image = await screenshotController.capture(
        delay: const Duration(milliseconds: 10));
    if (image == null) return null;

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "Screenshoot$time";
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = '$appDocPath/$name';

    if (await File(oldPath).exists()) {
    } else {
      File(oldPath).delete();
    }
    File file = File(filePath);
    await file.writeAsBytes(image);
    return await filePath;
  }

  @override
  Widget build(BuildContext context) {
    // bool _isVisible = true;
    // print('build ${Boxes.getCollection().get(0)!.elements[0].matrix4}');

    return Scaffold(
      // backgroundColor: Colors.brown.shade300,
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30),
            Header(index: 0, onTextChange: (String name, int index) {}),
            Screenshot(
              controller: screenshotController,
              child: Center(
                child: Container(
                  height: 500,
                  color: Colors.brown,
                  child: Stack(
                    children: List.generate(
                      collections[0].elements.length,
                      (index) => DraggableWidget(
                        initMatrix4: collections[0].elements[index].matrix4,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(elements[0].path)),
                        ),
                        onDoubleTap: () {},
                        onSave: (m4, str) {
                          _updateCollectionElement(
                              'saved', elements[0].path, m4, index);
                          print(str);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            BottonButtons(),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: showButton,
        child: Padding(
          padding: EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _addElement('test name1', elements[0].path);
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keyboardVisibilitySubscription.cancel();
    super.dispose();
  }
}

// final List<Widget> _dummyWidgets = [
//   Text("🙂", style: TextStyle(fontSize: 120)),
//   Icon(
//     Icons.favorite,
//     size: 120,
//     color: Colors.red,
//   ),
//   ClipRRect(
//     borderRadius: BorderRadius.circular(10),
//     child: Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(8),
//       child: Text(
//         'Test text ♥️',
//         style: TextStyle(fontSize: 18, color: Colors.black),
//       ),
//     ),
//   ),
// ];
