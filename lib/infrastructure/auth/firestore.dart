import 'package:assignment/domain/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestoredatas extends Istoreservice {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future adddatatofirestore({
    required Map<String, dynamic> data,
    required String collectionname,
  }) async {
    try {
      final response =
          await firebaseFirestore.collection(collectionname).doc().set(data);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @override
  Future updatedatafromfirestore(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    final response = await firebaseFirestore
        .collection(collectionname)
        .doc(docname)
        .update(data);
  }

  @override
  Future getdatafromfirestore(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    final response =
        await firebaseFirestore.collection(collectionname).doc(docname).get();
  }
}
