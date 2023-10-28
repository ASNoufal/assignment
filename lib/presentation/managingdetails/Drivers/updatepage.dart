import 'package:assignment/presentation/managingdetails/Drivers/Driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UpdatePage extends ConsumerWidget {
  const UpdatePage({super.key, required this.data});
  final Map<String, dynamic> data;

  Widget build(BuildContext context, WidgetRef ref) {
    final uuid = data["id"];

    final updatdata = TextEditingController(text: data["name"]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: updatdata,
              decoration: const InputDecoration(label: Text("Name")),
            ),
            ElevatedButton(
                onPressed: () {
                  final data = {"name": updatdata.text};

                  ref.read(torefreshprovider.notifier).update(
                        (state) => true,
                      );
                  updatedata(datas: data, doc: uuid)
                      .then((value) => Navigator.pop(context));
                },
                child: const Text("update"))
          ],
        ),
      ),
    );
  }

  Future<void> updatedata(
      {required Map<String, dynamic> datas, required String doc}) async {
    final data = FirebaseFirestore.instance.collection("userdriver").doc(doc);

    final snapshot = await data.update(datas);
  }
}
