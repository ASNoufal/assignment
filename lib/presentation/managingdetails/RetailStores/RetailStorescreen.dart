import 'package:assignment/presentation/Navigatingscreen/navigatingscreen.dart';
import 'package:assignment/presentation/managingdetails/RetailStores/updateRetailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Drivers/updatepage.dart';

List retailstore = ["a shop", "b shop", "cshop"];

class RetailStore extends ConsumerWidget {
  const RetailStore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(firestoredataprovider).getdatas;
    return Scaffold(
      backgroundColor: Colors.green[100],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
          onPressed: () {
            context.navigationtoscreen(
                child: const RetailStoredata(), isreplace: true);
          },
          child: const Text("Add Retailer")),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
          future: ref
              .read(firestoredataprovider)
              .getdatas(collection: "retaildata"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final datalist = snapshot.data;

              return ListView.builder(
                itemCount: datalist?.length ?? 0,
                itemBuilder: (context, index) {
                  final data = datalist![index];

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.green[300],
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return UpdateRetailer(
                            data: data,
                          );
                        }));
                      },
                      child: ListTile(
                        title: Text(
                          data['name'],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              ref.read(firestoredataprovider).deletedata(
                                  doc: data['id'], collection: "retaildata");
                            },
                            icon: const Icon(Icons.delete)),

                        // Add more fields as needed
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          }),
    );
  }
}

class RetailStoredata extends ConsumerWidget {
  const RetailStoredata({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final retaildata = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.green[100],
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
          onPressed: () {
            ref
                .read(firestoredataprovider.notifier)
                .createdata(name: retaildata.text, collection: "retaildata")
                .then((value) => Navigator.pop(context));
          },
          child: const Text("add details")),
      appBar: AppBar(
          backgroundColor: Colors.green[700], title: const Text("Retailstore")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: retaildata,
              decoration:
                  const InputDecoration(labelText: "Enter the Retailer name"),
            ),
          )
        ],
      ),
    );
  }
}
