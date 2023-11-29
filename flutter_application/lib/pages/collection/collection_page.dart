import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:flutter_application/pages/collection/draggable_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/services.dart';

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
  File? imageFile;

  @override
  void initState() {
    super.initState();

    if (collections.isEmpty) {
      Collection newCollection = Collection(
        name: 'name',
        elements: [],
        lastEdited: DateTime.now(),
        path: '',
      );
      Boxes.getCollection().add(newCollection);
      setState(() {
        collections = Boxes.getCollection().values.toList();
      });
    }
  }

  Future<void> _addElement(String name, String path) async {
    var collectionElement = CollectionElement(
      name: 'new',
      path: path,
      matrix4: Matrix4.identity(),
      screenshotPath: '',
    );

    setState(() {
      // aktualizacjia kolekcji w Hive, aby zapisac zmiany.
      Boxes.getCollection().getAt(0)!.elements.add(collectionElement);
      // jest to konieczne, aby Hive śledził i zapisywał zmiany.
      Boxes.getCollection().putAt(0, Boxes.getCollection().getAt(0)!);
    });
  }

  void _updateCollectionElement(
      String name, String path, Matrix4 m4, int index) async {
    String? path = await TakeScreenshotPath();
    if (path == null) return;

    CollectionElement element = CollectionElement(
      name: name,
      path: path,
      matrix4: m4,
      screenshotPath: path,
    );
    setState(() {
      Boxes.getCollection().getAt(0)!.elements[index] = element;
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

  Future<String?> TakeScreenshotPath() async {
    print('wywołano');
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

    File file = File(filePath);
    await file.writeAsBytes(image);

    print('Zapisano do galerji');
    Boxes.path = filePath;

    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    // print('build ${Boxes.getCollection().get(0)!.elements[0].matrix4}');
    String _ScreenshotPath = '';

    return Scaffold(
      backgroundColor: Colors.brown.shade300,
      body: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'Collection Name',
            style: TextStyle(fontSize: 30),
          ),
          Screenshot(
            controller: screenshotController,
            child: Container(
              height: 500,
              // margin: EdgeInsets.only(
              //   top: 30,
              //   bottom: 120,
              // ),
              decoration: BoxDecoration(
                color: Colors.brown,
                // borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
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
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          //dodawanie elementu do kolekcji
          onPressed: () {
            setState(
              () {
                _addElement('test name1', elements[0].path);
                print(collections.length);
                TakeScreenshotPath();
                // screenshot();
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
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
