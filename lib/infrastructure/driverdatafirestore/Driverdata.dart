import 'package:assignment/application/model/datamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firestoreprovider extends ChangeNotifier {
  ///map location need to get in the createdata. so i need to assign the name or location geonumber in the app
  ///currently i am updating in firestore after making the map and geolocator and integrating the map i can do.
  Future createdata({
    String? lon,
    String? lat,
    required String name,
    required String collection,
  }) async {
    final docuser = FirebaseFirestore.instance.collection(collection).doc();

    final user = Datamodel(
      id: docuser.id,
      name: name,
      lon: lon!,
      lat: lat!,
    );

    await docuser.set(user.toJson());
    notifyListeners();
  }

  Future<void> updatedata(
      {required Map<String, dynamic> datas,
      required String doc,
      required String collection}) async {
    final data = FirebaseFirestore.instance.collection(collection).doc(doc);

    final snapshot = await data.update(datas);
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> getdatas(
      {required String collection}) async {
    final data = FirebaseFirestore.instance.collection(collection);

    final documentSnapshot = await data.get();
    if (documentSnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> datalist = [];
      for (QueryDocumentSnapshot doc in documentSnapshot.docs) {
        datalist.add(doc.data() as Map<String, dynamic>);
      }
      return datalist;
    }
  }

  void deletedata({required String doc, required String collection}) {
    final data =
        FirebaseFirestore.instance.collection(collection).doc(doc).delete();
    notifyListeners();
  }

  getdatafromtheid({required String toGetthelatandlon}) async {
    var collection = FirebaseFirestore.instance.collection('retaildata');
    var docSnapshot = await collection.doc(toGetthelatandlon).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var value = data?['lat'];
      return value;
    }
  }
}
