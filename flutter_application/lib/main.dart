import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/application_data.dart';
import 'package:flutter_application/data/asset_exporter.dart';
import 'package:flutter_application/data/boxes.dart';
import 'package:flutter_application/data/colection.dart';
import 'package:flutter_application/data/matrix4_adapter.dart';
import 'package:flutter_application/data/my_element.dart';
import 'package:path_provider/path_provider.dart';
import 'data/clother_type_adapter.dart';
import 'pages/home_navbar.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters for your models
  Hive.registerAdapter(Matrix4Adapter());
  Hive.registerAdapter(ClotherTypeAdapter());
  Hive.registerAdapter(MyElementAdapter());
  Hive.registerAdapter(ColectionElementAdapter());
  Hive.registerAdapter(ColectionAdapter());
  Hive.registerAdapter(ApplicationDataAdapter());

  // Open boxes
  await Hive.openBox<MyElement>('myElementBox');
  // await Hive.deleteBoxFromDisk('myElementBox');
  await Hive.openBox<ColectionElement>('colectionElementBox');
  await Hive.openBox<Colection>('colectionBox');
  // await Hive.deleteBoxFromDisk('colectionBox');
  await Hive.openBox<ApplicationData>('appDataBox');
  // await Hive.deleteBoxFromDisk('applicationDataBox');
  Directory myDir = await getApplicationDocumentsDirectory();
  Boxes.appDir = myDir.path;

  AssetExporter assetExporter = AssetExporter();
  await assetExporter.copyAssetToFile('lib/assets/images', 'null.png');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //transparent bacground for system buttons
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    // Setting SystemUIMode // from transparent
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    // block screen rotation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // #endregion
    return MaterialApp(
      title: 'flutter_garderobe',
      debugShowCheckedModeBanner: false,
      home: HomeNavBar(),
      theme: ThemeData(
        textTheme: TextTheme(
            bodyLarge: TextStyle(
          color: Colors.brown.shade900,
          fontSize: 20,
        )),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          // labelStyle: TextStyle(
          //   color: Colors.brown.shade900,
          // ),
        ),
        scaffoldBackgroundColor: Colors.brown.shade400,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.brown.shade200,
          foregroundColor: Colors.brown.shade500,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.brown.shade200,
          selectionColor: Colors.brown.shade200,
          selectionHandleColor: Colors.transparent,
        ),
        // bottomAppBarTheme: BottomAppBarTheme(color: Colors.brown.shade400),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.brown.shade400,
        ),
        iconTheme: IconThemeData(
          size: 30,
          color: Colors.brown.shade800,
        ),
      ),
      // theme: ThemeData(primarySwatch: Colors.brown)
    );
  }
}
