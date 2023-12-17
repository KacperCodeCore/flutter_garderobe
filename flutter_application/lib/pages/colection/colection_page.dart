import 'dart:io';

import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/colection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/colection/colection_creator.dart';
import 'package:flutter_application/pages/colection/colection_footer.dart';
import 'package:flutter_application/pages/colection/draggable_widget.dart';
import 'package:flutter_application/pages/home/user_post.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../data/application_data.dart';
import '../../data/boxes.dart';
import 'header.dart';

class ColectionPage extends StatefulWidget {
  const ColectionPage({Key? key}) : super(key: key);

  @override
  State<ColectionPage> createState() => _ColectionPageState();
}

class _ColectionPageState extends State<ColectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var colections = Boxes.getColection().values.toList().cast<Colection>();
  var appData = Boxes.getAppData().values.toList().cast<ApplicationData>();

  bool showButton = true;
  late StreamSubscription<bool> _keyboardVisibilitySubscription;

  // ScreenshotController screenshotController = ScreenshotController();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    if (appData.isEmpty) {
      setState(() {
        Boxes.getAppData().add(ApplicationData());
      });
    }

    if (colections.isEmpty) {
      _addEmptyColection();
    }

    _keyboardVisibilitySubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      setState(() {
        _showHideButton(visible);
      });
    });
  }

  void _addEmptyColection() {
    Colection newColection = Colection(
      name: 'name',
      elements: [],
      lastEdited: DateTime.now(),
    );
    Boxes.getColection().add(newColection);
    setState(() {
      colections = Boxes.getColection().values.toList();
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
    if (colections.isEmpty) return;
    if (_pageController.page == null) {
      print('_pageController');
    }
    var colectionElement = ColectionElement(
      name: 'new',
      path: path,
      matrix4: Matrix4.identity(),
    );

    int index = _pageController.page!.round();
    setState(() {
      //todo za duzo operacji
      // aktualizacjia kolekcji w Hive, aby zapisac zmiany.
      Boxes.getColection().getAt(index)!.elements.add(colectionElement);
      // jest to konieczne, aby Hive śledził i zapisywał zmiany.
      Boxes.getColection().putAt(index, Boxes.getColection().getAt(index)!);
    });
  }

  Future<void> _updateColectionElement(String name, String path, Matrix4 m4,
      int index, ScreenshotController screenshotController) async {
    String? screenshotPath = await _TakeScreenshotPath(screenshotController);
    if (screenshotPath == null) return;

    ColectionElement element = ColectionElement(
      name: name,
      path: path,
      matrix4: m4,
    );
    int colectionIndex = _pageController.page!.round();
    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
    colection.elements[index] = element;
    colection.screenshotPath = screenshotPath;
    setState(() {
      Boxes.getColection().putAt(colectionIndex, colection);
      colections = Boxes.getColection().values.toList();
    });
  }

  void _deleteColectionElement(String id) {
    int colectionIndex = _pageController.page!.round();
    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
    // colection.elements.removeAt(index);
    colection.elements.removeWhere((e) => e.id == id);

    setState(() {
      Boxes.getColection().putAt(colectionIndex, colection);
      colections = Boxes.getColection().values.toList();
    });
  }

  Future<void> _SaveScreenshot(
      ScreenshotController screenshotController) async {
    int colectionIndex = _pageController.page!.round();
    print('_SaveScreenshot');
    String? _screenshotPath = await _TakeScreenshotPath(screenshotController);
    if (_screenshotPath == null) return;

    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
    colection.screenshotPath = _screenshotPath;
    setState(() {
      Boxes.getColection().putAt(colectionIndex, colection);
      colections = Boxes.getColection().values.toList();
    });
  }

  Future<String?> _TakeScreenshotPath(
      ScreenshotController screenshotController) async {
    int index = _pageController.page!.round();
    // String? oldPath = colections[index].screenshotPath;
    final Uint8List? image = await screenshotController.capture();
    if (image == null) return null;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    String currentFilePath = colections[index].screenshotPath;
    String filePath1 = '$appDocPath/Screenshoot${index}v1';
    String filePath2 = '$appDocPath/Screenshoot${index}v2';

    String newFilePath;
    if (currentFilePath == filePath1) {
      if (await File(filePath1).exists()) {
        print("Deleting File: $filePath1");
        await File(filePath1).delete();
      }
      newFilePath = filePath2;
    } else {
      if (await File(filePath2).exists()) {
        print("Deleting File: $filePath2");
        await File(filePath2).delete();
      }
      newFilePath = filePath1;
    }

    // nowy plik
    File file = File(newFilePath);
    await file.writeAsBytes(image);
    return await newFilePath;
  }

  bool _OverlapsParent(GlobalKey key, GlobalKey containerKey) {
    //pobiera dane kontenera
    RenderBox? contaiterBox =
        containerKey.currentContext?.findRenderObject() as RenderBox;
    Offset containerPisition = contaiterBox.localToGlobal(Offset.zero);
    double containerMaxX = containerPisition.dx;
    double containerMinX = containerPisition.dx + contaiterBox.size.width;
    double containerMaxY = containerPisition.dy;
    double containerMinY =
        containerPisition.dy + contaiterBox.size.height - 200;

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

  void _removeCurrentColection() {
    if (colections.isNotEmpty) {
      int currentPageIndex = _pageController.page!.round();
      _removeColection(currentPageIndex);
      setState(() {});
    }
  }

  void _removeColection(int index) {
    Boxes.getColection().deleteAt(index);
    colections = Boxes.getColection().values.toList().cast<Colection>();
  }

  void _addColectionAndGoTo() {
    _addEmptyColection();
    _pageController.jumpToPage(colections.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    // bool _isVisible = true;
    // print('build ${Boxes.getColection().get(0)!.elements[0].matrix4}');

    return Scaffold(
      // backgroundColor: Colors.brown.shade300,
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          SizedBox(height: 25),
          Container(
            height: 550,
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: colections.length,
              itemBuilder: (context, ColectionIndex) {
                ScreenshotController screenshotController =
                    ScreenshotController();
                final containerKey = GlobalKey();
                return ColectionCreator(
                  name: 'name',
                  child: Center(
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                        key: containerKey,
                        height: 500,
                        color: Colors.brown,
                        child: Stack(
                          children: List.generate(
                            colections[ColectionIndex].elements.length,
                            (index) {
                              final GlobalKey _sizeBoxKey = GlobalKey();
                              final GlobalKey _draggableKey = GlobalKey();
                              return DraggableWidget(
                                key: _draggableKey,
                                initMatrix4: colections[ColectionIndex]
                                    .elements[index]
                                    .matrix4,
                                child: SizedBox(
                                  key: _sizeBoxKey,
                                  height: 100,
                                  width: 100,
                                  child: Image.file(File(elements[0].path)),
                                ),
                                onDoubleTap: () {},
                                onSave: (m4) {
                                  if (_OverlapsParent(
                                    _sizeBoxKey,
                                    containerKey,
                                  )) {
                                    print('saving');
                                    _updateColectionElement(
                                        'saved',
                                        elements[0].path,
                                        m4,
                                        index,
                                        screenshotController);
                                  } else {
                                    _deleteColectionElement(
                                        colections[ColectionIndex]
                                            .elements[index]
                                            .id);
                                    // _SaveScreenshot();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ColectionFooter(
            previousPage: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                //todo sprawdzić jak są inne opcje
                curve: Curves.easeInOut,
              );
            },
            nextPage: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            deletePage: _removeCurrentColection,
            addPage: _addColectionAndGoTo,
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: showButton,
        child: Padding(
          padding: EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            onPressed: () {
              _addElement('test name1', elements[0].path);
              // _SaveScreenshot();
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
