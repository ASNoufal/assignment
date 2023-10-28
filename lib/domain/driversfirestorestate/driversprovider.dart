import 'package:assignment/infrastructure/auth/driversfirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Driversprovider extends ChangeNotifier {
  Driverdata driver = Driverdata();

  Future<void> adddata(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    final response = await driver.adddatatofirestore(
      data: data,
      collectionname: collectionname,
    );
  }

  Future getdata(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    final response = await driver.getdatafromfirestore(
        collectionname: collectionname, data: data, docname: docname);
  }

  Future<void> updatedata(
      {required Map<String, dynamic> data,
      required String collectionname,
      required String docname}) async {
    final response = await driver.updatedatafromfirestore(
        data: data, collectionname: collectionname, docname: docname);
  }
}

final driverprovide =
    ChangeNotifierProvider<Driversprovider>((ref) => Driversprovider());
