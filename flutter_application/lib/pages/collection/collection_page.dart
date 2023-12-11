import 'dart:io';

import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/botton_buttons.dart';
import 'package:flutter_application/pages/collection/draggable_widget.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../data/application_data.dart';
import '../../data/boxes.dart';
import 'header.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var collections = Boxes.getCollection().values.toList().cast<Collection>();
  var appData = Boxes.getAppData().values.toList().cast<ApplicationData>();
  late int cIndex;

  ScreenshotController screenshotController = ScreenshotController();
  bool showButton = true;
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  final containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (appData.isEmpty) {
      setState(() {
        Boxes.getAppData().add(ApplicationData());
      });
    }
    cIndex = appData[0].collectionIndex;

    if (collections.isEmpty) {
      _addEmptyCollection();
    }

    _keyboardVisibilitySubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      setState(() {
        _showHideButton(visible);
      });
    });
  }

  void _addEmptyCollection() {
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

  void _showHideButton(bool isKeyboardVisible) {
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

    Collection collection = Boxes.getCollection().getAt(cIndex)!;
    collection.elements[index] = element;
    collection.screenshotPath = _screenshotPath;
    setState(() {
      Boxes.getCollection().putAt(cIndex, collection);
      collections = Boxes.getCollection().values.toList();
    });
  }

  void _deleteCollectionElement(String id) {
    Collection collection = Boxes.getCollection().getAt(0)!;
    // collection.elements.removeAt(index);
    collection.elements.removeWhere((e) => e.id == id);

    setState(() {
      Boxes.getCollection().putAt(0, collection);
      collections = Boxes.getCollection().values.toList();
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

  bool _OverlapsParent(GlobalKey key) {
    //pobiera dane kontenera
    RenderBox? contaiterBox =
        containerKey.currentContext?.findRenderObject() as RenderBox;
    Offset containerPisition = contaiterBox.localToGlobal(Offset.zero);
    double containerMaxX = containerPisition.dx;
    double containerMinX = containerPisition.dx + contaiterBox.size.width;
    double containerMaxY = containerPisition.dy;
    double containerMinY = containerPisition.dy + contaiterBox.size.height;

    // pobiera dane konkretnego dragablebox
    RenderBox? draggableBox =
        key.currentContext?.findRenderObject() as RenderBox?;

    if (draggableBox == null) return false;
    List<Offset> vertices = [
      Offset(0, 0),
      Offset(draggableBox.size.width, 0),
      Offset(draggableBox.size.width, draggableBox.size.height),
      Offset(0, draggableBox.size.height),
    ];

    List<Offset> globalVertices =
        vertices.map((vertex) => draggableBox.localToGlobal(vertex)).toList();

    // lista warunków do spełnienia
    List<bool Function(Offset)> checkVertexBounds = [
      (Offset vertex) => vertex.dx > containerMaxX,
      (Offset vertex) => vertex.dx < containerMinX,
      (Offset vertex) => vertex.dy > containerMaxY,
      (Offset vertex) => vertex.dy < containerMinY,
    ];

    // sprawdza, czy wszystkie wierzchołki są po tej samej stronie poza rodzicem
    for (var item in checkVertexBounds) {
      int counter = 0;

      for (Offset vertex in globalVertices) {
        if (item(vertex)) {
          break;
        }
        counter++;
        if (counter >= 4) {
          return false;
        }
      }
    }

    return true;
  }

  void _ShowIndexCollection(int index) {
    appData[0].collectionIndex = index;
    setState(() {
      Boxes.getAppData().putAt(0, appData[0]);
      cIndex = appData[0].collectionIndex;
    });
    print(cIndex);
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
            Header(
              index: appData[0].collectionIndex,
              length: collections.length,
              onTextChange: (String name, int index) {},
              onPressed: (index) {
                if (index > collections.length - 1) {
                  _addEmptyCollection();
                }
                _ShowIndexCollection(index);
                print('collectionIndex $index');
              },
            ),
            Screenshot(
              controller: screenshotController,
              child: Center(
                child: Container(
                  key: containerKey,
                  height: 500,
                  color: Colors.brown,
                  child: Stack(
                    children: List.generate(collections[cIndex].elements.length,
                        (index) {
                      final GlobalKey _sizeBoxKey = GlobalKey();
                      final GlobalKey _draggableKey = GlobalKey();
                      return DraggableWidget(
                        key: _draggableKey,
                        initMatrix4:
                            collections[cIndex].elements[index].matrix4,
                        child: SizedBox(
                          key: _sizeBoxKey,
                          height: 100,
                          width: 100,
                          child: Image.file(File(elements[0].path)),
                        ),
                        onDoubleTap: () {},
                        onSave: (m4) {
                          if (_OverlapsParent(_sizeBoxKey)) {
                            _updateCollectionElement(
                                'saved', elements[0].path, m4, index);
                          } else {
                            _deleteCollectionElement(
                                collections[cIndex].elements[index].id);
                          }
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            BottonButtons(
              onDelete: () {},
            ),
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
