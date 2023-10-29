// import 'package:assignment/application/model/datamodel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final retaildataprovider =
//     ChangeNotifierProvider<RetailStoredata>((ref) => RetailStoredata());

// class RetailStoredata extends ChangeNotifier {
//   FirebaseFirestore db = FirebaseFirestore.instance;

//   Future adddata(
//       String name,String id) async {
//     final snapshot = db.collection("").doc();

//     final user = Datamodel(id: id, name: name);

//      await snapshot.set(user.toJson());
//   }

//   Future getdata(){
//     final snapshot = db.collection()

//   }
// }
