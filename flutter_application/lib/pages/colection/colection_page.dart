import 'dart:io';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/colection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/colection/colection_bottom_sheet.dart';
import 'package:flutter_application/pages/colection/colection_creator.dart';
import 'package:flutter_application/pages/colection/colection_footer.dart';
import 'package:flutter_application/pages/colection/draggable_widget.dart';

import 'package:screenshot/screenshot.dart';

import '../../data/application_data.dart';
import '../../data/boxes.dart';

class ColectionPage extends StatefulWidget {
  final int collectionInitialIndex;

  const ColectionPage({
    super.key,
    required this.collectionInitialIndex,
  });

  @override
  State<ColectionPage> createState() => _ColectionPageState();
}

class _ColectionPageState extends State<ColectionPage> {
  var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
  var colections = Boxes.getColection().values.toList().cast<Colection>();
  var appData = Boxes.getAppData().values.toList().cast<ApplicationData>();

  bool showButton = true;
  // late StreamSubscription<bool> _keyboardVisibilitySubscription;

  ScreenshotController _screenshotController = ScreenshotController();
  late PageController _pageController;

  @override
  void initState() {
    if (appData.isEmpty) {
      setState(() {
        Boxes.getAppData().add(ApplicationData());
      });
    }

    if (colections.isEmpty) {
      _addEmptyColection();
    }

    // // todo
    // _keyboardVisibilitySubscription =
    //     KeyboardVisibilityController().onChange.listen((visible) {
    //   setState(() {
    //     _showHideButton(visible);
    //   });
    // });

    super.initState();

    _pageController = PageController(
      initialPage: Boxes.getAppData().get('appDataKey')!.colectionIndex,
    );

    _pageController.addListener(() {
      Boxes.getAppData().put('appDataKey',
          ApplicationData(colectionIndex: _pageController.page!.round()));
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

  // void _showHideButton(bool isKeyboardVisible) {
  //   if (isKeyboardVisible) {
  //     showButton = false;
  //   } else {
  //     Future.delayed(Duration(milliseconds: 400), () {
  //       setState(() {
  //         showButton = true;
  //       });
  //     });
  //   }
  //   print('showButton $showButton');
  // }

  Future<void> _addElement(MyElement myElement) async {
    if (colections.isEmpty) return;
    print('added h ${myElement.height}, w ${myElement.width}');

    double width = 100.0;
    double height = width * myElement.height / myElement.width;

    var colectionElement = ColectionElement(
      name: myElement.name,
      path: myElement.path,
      matrix4: Matrix4.identity(),
      height: height,
      width: width,
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
      int index, double height, double width) async {
    ColectionElement element = ColectionElement(
      name: name,
      path: path,
      matrix4: m4,
      height: height,
      width: width,
    );
    int colectionIndex = _pageController.page!.round();
    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
    colection.elements[index] = element;

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

  void _TakeScreenshot() async {
    _screenshotController.capture().then((Uint8List? image) {
      _saveScreenshot(image!);
    }).catchError((error) {
      print(error);
    });
  }

  void _saveScreenshot(Uint8List image) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;

    String newFilePath = '${Boxes.appDir}/Screenshoot$time';

    int colectionIndex = _pageController.page!.round();
    String? oldFilePath = colections[colectionIndex].screenshotPath;
    if (oldFilePath != null && !(await File(oldFilePath).exists())) {
      File(oldFilePath).delete();
    }
    File file = File(newFilePath);
    await file.writeAsBytes(image);

    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
    colection.screenshotPath = newFilePath;

    Boxes.getColection().putAt(colectionIndex, colection);
  }

  bool _overlapsParent(GlobalKey key, GlobalKey containerKey) {
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

  void _updateCollectionIndex() {
    Boxes.getAppData().put('appDataKey',
        ApplicationData(colectionIndex: _pageController.page!.round()));
    // Boxes.getAppData().put('appDataKey',
    //     ApplicationData(colectionIndex: _pageController.page!.round()));
    print(
        'page index: ${Boxes.getAppData().get('appDataKey')!.colectionIndex}');
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      //todo sprawdzić jak są inne opcje
      curve: Curves.easeInOut,
    );
    _updateCollectionIndex();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    _updateCollectionIndex();
  }

  void _deleteCurrentColection() {
    if (colections.isNotEmpty) {
      int currentPageIndex = _pageController.page!.round();
      _deleteColection(currentPageIndex);
      _updateCollectionIndex();
      setState(() {});
    }
  }

  void _deleteColection(int index) {
    Boxes.getColection().deleteAt(index);
    //todo rename collection
    colections = Boxes.getColection().values.toList().cast<Colection>();
  }

  void _addColectionAndGoTo() {
    _addEmptyColection();
    _pageController.jumpToPage(colections.length - 1);
    _updateCollectionIndex();
  }

  void _renameCollection() {}

  @override
  Widget build(BuildContext context) {
    // bool _isVisible = true;
    // print('build ${Boxes.getColection().get(0)!.elements[0].matrix4}');

    return Scaffold(
      // backgroundColor: Colors.brown.shade300,
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 630,
            child: Center(
              child: Screenshot(
                controller: _screenshotController,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: colections.length,
                  itemBuilder: (context, ColectionIndex) {
                    final containerKey = GlobalKey();
                    return ColectionCreator(
                      name: 'Name',
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Container(
                            key: containerKey,
                            color: Colors.brown.shade100,
                            child: Stack(
                              children: List.generate(
                                colections[ColectionIndex].elements.length,
                                (index) {
                                  final element = colections[ColectionIndex]
                                      .elements[index];

                                  final GlobalKey _sizeBoxKey = GlobalKey();
                                  final GlobalKey _draggableKey = GlobalKey();

                                  return DraggableWidget(
                                    key: _draggableKey,
                                    initMatrix4: element.matrix4,
                                    child: SizedBox(
                                      key: _sizeBoxKey,
                                      height: element.height,
                                      width: element.width,
                                      // if image.path is null
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.file(
                                            File(
                                              File(element.path).existsSync()
                                                  ? element.path
                                                  : '${Boxes.appDir}/null.png',
                                            ),
                                            fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                    onDoubleTap: () {},
                                    onSave: (m4) {
                                      print(
                                          'h ${element.height} w ${element.width}');
                                      if (_overlapsParent(
                                        _sizeBoxKey,
                                        containerKey,
                                      )) {
                                        print('saving');
                                        _updateColectionElement(
                                          'saved',
                                          element.path,
                                          m4,
                                          index,
                                          element.height,
                                          element.width,
                                        );
                                        _TakeScreenshot();
                                      } else {
                                        _deleteColectionElement(
                                            colections[ColectionIndex]
                                                .elements[index]
                                                .id);
                                        _TakeScreenshot();
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
            ),
          ),
          ColectionFooter(
            previousPage: _previousPage,
            nextPage: _nextPage,
            deletePage: _deleteCurrentColection,
            addPage: _addColectionAndGoTo,
            rename: _renameCollection,
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: showButton,
        child: Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            onPressed: () {
              if (colections.length == 0) return;
              //todo DraggableScrollable
              showModalBottomSheet(
                backgroundColor: Colors.brown.shade400,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ColectionBottomSheet(
                    onTap: (myElement) {
                      _addElement(myElement);
                      _TakeScreenshot();
                    },
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _keyboardVisibilitySubscription.cancel();
    _TakeScreenshot();
    _pageController.dispose();
    super.dispose();
  }
}
