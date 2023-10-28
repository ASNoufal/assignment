// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:assignment/application/model/datamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:assignment/domain/driversfirestorestate/driversprovider.dart';
import 'package:assignment/presentation/Navigatingscreen/navigatingscreen.dart';
import 'package:assignment/presentation/managingdetails/RetailStores/RetailStorescreen.dart';

Map<String, dynamic> datamap = {};

class Driver extends ConsumerWidget {
  String? firstname;
  Driver({
    this.firstname,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(driverprovide);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            context.navigationtoscreen(
                child: const DriversData(), isreplace: true);
          },
          child: Text("Add Drivers")),
      body: Column(children: [
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: getdatas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final datalist = snapshot.data;
                  return ListView.builder(
                    itemCount: datalist?.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = datalist![index];
                      return ListTile(
                        title: Text(data['name']),

                        // Add more fields as needed
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data available"));
                }
              }),
        )
      ]),
    );
  }

  Future<List<Map<String, dynamic>>?> getdatas() async {
    final data = FirebaseFirestore.instance.collection("userdriver");

    final documentSnapshot = await data.get();
    if (documentSnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> datalist = [];
      for (QueryDocumentSnapshot doc in documentSnapshot.docs) {
        datalist.add(doc.data() as Map<String, dynamic>);
      }
      return datalist;
    }
  }

  // Stream<List<Datamodel>> getdata() {
  //   FirebaseFirestore.instance
  //       .collection("userdriver")
  //       .snapshots()
  //       .map((event) => event.docs.map((e) => print(e.toString())));
  //   return FirebaseFirestore.instance.collection("userdriver").snapshots().map(
  //       (snapshot) =>
  //           snapshot.docs.map((e) => Datamodel.fromJson(e.data())).toList());
  // }
}

Widget builduser(Datamodel datamodel) {
  return ListTile(
    title: Text(datamodel.name),
  );
}

class DriversData extends ConsumerWidget {
  const DriversData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(driverprovide);
    final driverdatacontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: driverdatacontroller,
            decoration: const InputDecoration(labelText: "Enter the driver"),
          ),
        ),
        ElevatedButton(
            child: const Text("ok"),
            onPressed: () async {
              createdata(name: driverdatacontroller.text);
              Navigator.pop(context);
            })
      ]),
    );
  }

  Future createdata({required String name}) async {
    final docuser = FirebaseFirestore.instance.collection("userdriver").doc();

    final user = Datamodel(id: docuser.id, name: name);

    await docuser.set(user.toJson());
  }
}
