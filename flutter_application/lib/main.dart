import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/data/collection.dart';
import 'package:flutter_application/data/my_element.dart';
import 'pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters for your models
  Hive.registerAdapter(MyElementAdapter());
  Hive.registerAdapter(CollectionElementAdapter());
  Hive.registerAdapter(CollectionAdapter());

  // Open boxes
  await Hive.openBox<MyElement>('myElementBox');
  await Hive.openBox<CollectionElement>('collectionElementBox');
  await Hive.openBox<Collection>('collectionBox');

  // Run your app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // #region Description
    // hide statusbar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);

    //transparent bacground for system buttons
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromARGB(0, 155, 53, 53),
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      // statusBarColor: Colors.transparent,
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
      home: HomePage(),
      // theme: ThemeData(primarySwatch: Colors.brown)
    );
  }
}
