import 'package:assignment/application/model/datamodel.dart';
import 'package:assignment/domain/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Driverdata extends Istoreservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future adddatatofirestore({
    required Map<String, dynamic> data,
    required String collectionname,
  }) async {
    try {
      final response =
          await firestore.collection(collectionname).doc().set(data);
      return response;
    } catch (e) {
      print(e);

      throw Exception(e);
    }
  }

  @override
  Future getdatafromfirestore(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    try {
      final response =
          await firestore.collection(collectionname).doc(docname).get();
    } catch (e) {
      print(e);

      throw Exception(e);
    }
  }

  @override
  Future updatedatafromfirestore(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    try {
      final response =
          await firestore.collection(collectionname).doc(docname).update(data);
      return response;
    } catch (e) {
      print(e);

      throw Exception(e);
    }
  }
}
