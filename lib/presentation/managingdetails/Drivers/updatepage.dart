import 'package:assignment/infrastructure/driverdatafirestore/Driverdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoredataprovider =
    ChangeNotifierProvider<Firestoreprovider>((ref) => Firestoreprovider());

class UpdatePage extends ConsumerWidget {
  const UpdatePage({super.key, required this.data});
  final Map<String, dynamic> data;

  Widget build(BuildContext context, WidgetRef ref) {
    final uuid = data["id"];

    final updatdata = TextEditingController(text: data["name"]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
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
                  ref
                      .read(firestoredataprovider.notifier)
                      .updatedata(
                        datas: data,
                        doc: uuid,
                        collection: "userdriver",
                      )
                      .then((value) => Navigator.pop(context));
                  // updatedata(datas: data, doc: uuid)
                  // .then((value) => Navigator.pop(context));
                },
                child: const Text("update"))
          ],
        ),
      ),
    );
  }
}
