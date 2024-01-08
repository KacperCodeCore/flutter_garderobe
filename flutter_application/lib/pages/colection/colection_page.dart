import 'dart:io';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/clother_type_adapter.dart';
import 'package:flutter_application/data/colection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/colection/colection_bottom_sheet.dart';
import 'package:flutter_application/pages/colection/colection_creator.dart';
import 'package:flutter_application/pages/colection/colection_footer.dart';
import 'package:flutter_application/pages/colection/draggable_widget.dart';

import 'package:screenshot/screenshot.dart';

import '../../assets/widgets/sheet_holder.dart';
import '../../data/application_data.dart';
import '../../data/boxes.dart';
import 'rename_bottom_sheet.dart';

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
  List<MyElement> elements = [];
  Set<ClotherType> uniquetype = {};
  Map<ClotherType, List<MyElement>> groupedElements = {};

  var colections = Boxes.getColection().values.toList().cast<Colection>();
  var appData = Boxes.getAppData().values.toList().cast<ApplicationData>();

  bool showButton = true;

  ScreenshotController _screenshotController = ScreenshotController();
  late PageController _pageController;

  @override
  void initState() {
    elements = Boxes.getMyElements().values.toList().cast<MyElement>();
    uniquetype = Boxes.getMyElements().values.map((e) => e.type).toSet();

    for (ClotherType type in uniquetype)
      groupedElements[type] =
          elements.where((element) => element.type == type).toList();

    if (appData.isEmpty) {
      setState(() {
        Boxes.getAppData().add(ApplicationData());
      });
    }

    if (colections.isEmpty) {
      _addEmptyColection();
    }

    super.initState();

    _pageController = PageController(
      initialPage: Boxes.getAppData().get('appDataKey')!.colectionIndex,
    );

    _pageController.addListener(() {
      Boxes.getAppData().put('appDataKey',
          ApplicationData(colectionIndex: _pageController.page!.round()));
    });
  }

  void handleFABPress() {
    if (colections.length == 0) return;
    //todo DraggableScrollable
    showModalBottomSheet(
      backgroundColor: Colors.brown.shade400,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ColectionBottomSheet(
          groupedElements: groupedElements,
          onTap: (myElement) {
            _addElement(myElement);
            _TakeScreenshot();
          },
        );
      },
    );
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
    _TakeScreenshot();
  }

  Future<void> _addElement(MyElement myElement, [Matrix4? m4]) async {
    if (colections.isEmpty) return;

    ColectionElement colectionElement = ColectionElement(
      matrix4: m4 ?? Matrix4.identity(),
      myElement: myElement,
    );

    int index = _pageController.page!.round();
    setState(() {
      Boxes.getColection().getAt(index)!.elements.add(colectionElement);
    });
  }

  void _updateColectionElement(
      int index, Matrix4 m4, MyElement myElement) async {
    ColectionElement element = ColectionElement(
      matrix4: m4,
      myElement: myElement,
    );

    int colectionIndex = _pageController.page!.round();
    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
    colection.elements[index] = element;

    _updateColection(colection, colectionIndex);
  }

  void _updateColection(Colection colection, int colectionIndex) {
    setState(() {
      Boxes.getColection().putAt(colectionIndex, colection);
      colections = Boxes.getColection().values.toList();
    });
  }

  void _deleteColectionElement(String id) {
    int colectionIndex = _pageController.page!.round();
    Colection colection = Boxes.getColection().getAt(colectionIndex)!;
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

  void _elementOnPressed(Matrix4 m4, ColectionElement element) {
    _deleteColectionElement(element.id);
    _addElement(element.myElement, m4);
  }

  void _elementOnTap(Matrix4 m4, int index, MyElement myElement, bool oneTap) {
    // myElement.type exsist ?
    if (!groupedElements.containsKey(myElement.type)) return;

    int ElementIndex = groupedElements[myElement.type]!
        .indexWhere((e) => e.id == myElement.id);
    if (ElementIndex == -1) return;
    if (groupedElements[myElement.type]!.length < 2) return;

    if (oneTap) {
      if (ElementIndex >= groupedElements[myElement.type]!.length - 1) {
        ElementIndex = 0;
      } else {
        ElementIndex++;
      }
    } else {
      if (ElementIndex == 0) {
        ElementIndex = groupedElements[myElement.type]!.length - 1;
      } else {
        ElementIndex--;
      }
    }

    MyElement nextElement = groupedElements[myElement.type]![ElementIndex];

    _updateColectionElement(index, m4, nextElement);
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
    if (colections.isEmpty) return;

    int currentPageIndex = _pageController.page!.round();
    _deleteColection(currentPageIndex);
    _updateCollectionIndex();
    setState(() {});
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

  void _showBottomRenameSheet() {
    if (colections.isEmpty) return;

    int colectionIndex = _pageController.page!.round();
    Colection colection = Boxes.getColection().getAt(colectionIndex)!;

    final TextEditingController _textController = TextEditingController();
    _textController.text = colection.name;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return RenameBottomSheet(
          textController: _textController,
          updateCollection: (name) {
            colection.name = name;
            _updateColection(colection, colectionIndex);
            _TakeScreenshot();
          },
          initialName: colection.name,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                    itemBuilder: (context, colectionIndex) {
                      final containerKey = GlobalKey();
                      return ColectionCreator(
                        name: colections[colectionIndex].name,
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
                                  colections[colectionIndex].elements.length,
                                  (index) {
                                    final element = colections[colectionIndex]
                                        .elements[index];

                                    final GlobalKey _sizeBoxKey = GlobalKey();
                                    final GlobalKey _draggableKey = GlobalKey();

                                    return DraggableWidget(
                                      key: _draggableKey,
                                      initMatrix4: element.matrix4,
                                      child: SizedBox(
                                        key: _sizeBoxKey,
                                        height: element.myElement.height,
                                        width: element.myElement.width,
                                        // if image.path is null
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.file(
                                              File(
                                                File(element.myElement.path)
                                                        .existsSync()
                                                    ? element.myElement.path
                                                    : '${Boxes.appDir}/null.png',
                                              ),
                                              fit: BoxFit.fitWidth),
                                        ),
                                      ),
                                      onTap: (m4) {
                                        _elementOnTap(
                                          m4,
                                          index,
                                          element.myElement,
                                          true,
                                        );
                                        _TakeScreenshot();
                                      },
                                      onDoubleTap: (m4) {
                                        _elementOnTap(
                                          m4,
                                          index,
                                          element.myElement,
                                          false,
                                        );
                                        _TakeScreenshot();
                                      },
                                      onPressed: (m4) {
                                        _elementOnPressed(m4, element);
                                        _TakeScreenshot();
                                      },
                                      onSave: (m4) {
                                        if (_overlapsParent(
                                          _sizeBoxKey,
                                          containerKey,
                                        )) {
                                          _updateColectionElement(
                                            index,
                                            m4,
                                            element.myElement,
                                          );
                                          _TakeScreenshot();
                                        } else {
                                          _deleteColectionElement(element.id);
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
              rename: _showBottomRenameSheet,
            ),
          ],
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
