import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialize Hive
  await Hive.initFlutter();

  //open a box //? needed?
  var box = await Hive.openBox('myBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter_garderobe',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(primarySwatch: Colors.brown));
  }
}
