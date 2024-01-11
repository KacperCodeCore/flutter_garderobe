import 'dart:io';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/clothe_type_adapter.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/collection_bottom_sheet.dart';
import 'package:flutter_application/pages/collection/collection_creator.dart';
import 'package:flutter_application/pages/collection/collection_footer.dart';
import 'package:flutter_application/pages/collection/draggable_widget.dart';

import 'package:screenshot/screenshot.dart';

import '../../data/application_data.dart';
import '../../data/boxes.dart';
import 'rename_bottom_sheet.dart';

class CollectionPage extends StatefulWidget {
  final int collectionInitialIndex;

  const CollectionPage({
    super.key,
    required this.collectionInitialIndex,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<MyElement> elements = [];
  Set<ClotheType> uniqueType = {};
  Map<ClotheType, List<MyElement>> groupedElements = {};

  var collections = Boxes.getCollection().values.toList().cast<Collection>();
  var appData = Boxes.getAppData().values.toList().cast<ApplicationData>();

  bool showButton = true;

  ScreenshotController _screenshotController = ScreenshotController();
  late PageController _pageController;

  @override
  void initState() {
    elements = Boxes.getMyElements().values.toList().cast<MyElement>();
    uniqueType = Boxes.getMyElements().values.map((e) => e.type).toSet();

    for (ClotheType type in uniqueType)
      groupedElements[type] =
          elements.where((element) => element.type == type).toList();

    if (appData.isEmpty) {
      setState(() {
        Boxes.getAppData().add(ApplicationData());
      });
    }

    if (collections.isEmpty) {
      _addEmptyCollection();
    }

    super.initState();

    _pageController = PageController(
      initialPage: Boxes.getAppData().get('appDataKey')!.collectionIndex,
    );

    _pageController.addListener(() {
      Boxes.getAppData().put('appDataKey',
          ApplicationData(collectionIndex: _pageController.page!.round()));
    });
  }

  void handleFABPress() {
    if (collections.length == 0) return;
    //todo DraggableScrollable
    showModalBottomSheet(
      backgroundColor: Colors.brown.shade400,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return CollectionBottomSheet(
          groupedElements: groupedElements,
          onTap: (myElement) {
            _addElement(myElement);
            _TakeScreenshot();
          },
        );
      },
    );
  }

  void _addEmptyCollection() {
    Collection newCollection = Collection(
      name: 'name',
      elements: [],
      lastEdited: DateTime.now(),
    );
    Boxes.getCollection().add(newCollection);
    setState(() {
      collections = Boxes.getCollection().values.toList();
    });
    _TakeScreenshot();
  }

  Future<void> _addElement(MyElement myElement, [Matrix4? m4]) async {
    if (collections.isEmpty) return;

    CollectionElement collectionElement = CollectionElement(
      matrix4: m4 ?? Matrix4.identity(),
      myElement: myElement,
    );

    int index = _pageController.page!.round();
    setState(() {
      Boxes.getCollection().getAt(index)!.elements.add(collectionElement);
    });
  }

  void _updateCollectionElement(
      int index, Matrix4 m4, MyElement myElement) async {
    CollectionElement element = CollectionElement(
      matrix4: m4,
      myElement: myElement,
    );

    int collectionIndex = _pageController.page!.round();
    Collection collection = Boxes.getCollection().getAt(collectionIndex)!;
    collection.elements[index] = element;

    _updateCollection(collection, collectionIndex);
  }

  void _updateCollection(Collection collection, int collectionIndex) {
    setState(() {
      Boxes.getCollection().putAt(collectionIndex, collection);
      collections = Boxes.getCollection().values.toList();
    });
  }

  void _deleteCollectionElement(String id) {
    int collectionIndex = _pageController.page!.round();
    Collection collection = Boxes.getCollection().getAt(collectionIndex)!;
    collection.elements.removeWhere((e) => e.id == id);

    setState(() {
      Boxes.getCollection().putAt(collectionIndex, collection);
      collections = Boxes.getCollection().values.toList();
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

    String newFilePath = '${Boxes.appDir}/ScreenShoot$time';

    int collectionIndex = _pageController.page!.round();
    String? oldFilePath = collections[collectionIndex].screenshotPath;
    if (oldFilePath != null && !(await File(oldFilePath).exists())) {
      File(oldFilePath).delete();
    }
    File file = File(newFilePath);
    await file.writeAsBytes(image);

    Collection collection = Boxes.getCollection().getAt(collectionIndex)!;
    collection.screenshotPath = newFilePath;

    Boxes.getCollection().putAt(collectionIndex, collection);
  }

  void _elementOnPressed(Matrix4 m4, CollectionElement element) {
    _deleteCollectionElement(element.id);
    _addElement(element.myElement, m4);
  }

  void _elementOnTap(Matrix4 m4, int index, MyElement myElement, bool oneTap) {
    // myElement.type exist ?
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

    _updateCollectionElement(index, m4, nextElement);
  }

  bool _overlapsParent(GlobalKey key, GlobalKey containerKey) {
    //retrieves the data of Container
    RenderBox? containerBox =
        containerKey.currentContext?.findRenderObject() as RenderBox;
    Offset containerPosition = containerBox.localToGlobal(Offset.zero);
    double containerMaxX = containerPosition.dx;
    double containerMinX = containerPosition.dx + containerBox.size.width;
    double containerMaxY = containerPosition.dy;
    double containerMinY = containerPosition.dy + containerBox.size.height;

    // retrieves the data of a specific draggableBox
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

    // list of conditions
    List<bool Function(Offset)> checkVertexBounds = [
      (Offset vertex) => vertex.dx > containerMaxX,
      (Offset vertex) => vertex.dx < containerMinX,
      (Offset vertex) => vertex.dy > containerMaxY,
      (Offset vertex) => vertex.dy < containerMinY,
    ];

    // checks if all vertices are on the same side except the parent
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
        ApplicationData(collectionIndex: _pageController.page!.round()));
    print(
        'page index: ${Boxes.getAppData().get('appDataKey')!.collectionIndex}');
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
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

  void _deleteCurrentCollection() {
    if (collections.isEmpty) return;

    int currentPageIndex = _pageController.page!.round();
    _deleteCollection(currentPageIndex);
    _updateCollectionIndex();
    setState(() {});
  }

  void _deleteCollection(int index) {
    Boxes.getCollection().deleteAt(index);
    //todo rename collection
    collections = Boxes.getCollection().values.toList().cast<Collection>();
  }

  void _addCollectionAndGoTo() {
    _addEmptyCollection();
    _pageController.jumpToPage(collections.length - 1);
    _updateCollectionIndex();
  }

  void _showBottomRenameSheet() {
    if (collections.isEmpty) return;

    int collectionIndex = _pageController.page!.round();
    Collection collection = Boxes.getCollection().getAt(collectionIndex)!;

    final TextEditingController _textController = TextEditingController();
    _textController.text = collection.name;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return RenameBottomSheet(
          textController: _textController,
          updateCollection: (name) {
            collection.name = name;
            _updateCollection(collection, collectionIndex);
            _TakeScreenshot();
          },
          initialName: collection.name,
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
                    itemCount: collections.length,
                    itemBuilder: (context, collectionIndex) {
                      final containerKey = GlobalKey();
                      return CollectionCreator(
                        name: collections[collectionIndex].name,
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
                                  collections[collectionIndex].elements.length,
                                  (index) {
                                    final element = collections[collectionIndex]
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
                                          _updateCollectionElement(
                                            index,
                                            m4,
                                            element.myElement,
                                          );
                                          _TakeScreenshot();
                                        } else {
                                          _deleteCollectionElement(element.id);
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
            CollectionFooter(
              previousPage: _previousPage,
              nextPage: _nextPage,
              deletePage: _deleteCurrentCollection,
              addPage: _addCollectionAndGoTo,
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
