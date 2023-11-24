// import 'package:flutter/material.dart';

// import '../../data/boxes.dart';
// import '../../data/collection.dart';
// import '../../data/my_element.dart';

// class CollectionPage extends StatefulWidget {
//   const CollectionPage({super.key});

//   @override
//   State<CollectionPage> createState() => _CollectionPageState();
// }

// class _CollectionPageState extends State<CollectionPage> {
//   var elements = Boxes.getMyElements().values.toList().cast<MyElement>();
//   var collectionElements =
//       Boxes.getCollectionElement().values.toList().cast<CollectionElement>();
//   var collections = Boxes.getCollection().values.toList().cast<Collection>();

//   @override
// void initState() {
//   super.initState();
//     if (Boxes.getCollection().isEmpty) {
//       List<CollectionElement> element = [];
//       Collection newCollection = Collection(
//         name: 'name',
//         elements: element,
//         lastEdited: DateTime.now(),
//       );
//       Boxes.getCollection().add(newCollection);
// }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
