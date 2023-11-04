// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assignment/application/model/datamodel.dart';
import 'package:assignment/presentation/Login/Loginform.dart';
import 'package:assignment/presentation/managingdetails/Drivers/updatepage.dart';
import 'package:flutter/material.dart';

import 'package:assignment/presentation/Navigatingscreen/navigatingscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? intial = "Select the store";

class Driver extends ConsumerStatefulWidget {
  const Driver({super.key});

  @override
  ConsumerState<Driver> createState() => _DriverState();
}

class _DriverState extends ConsumerState<Driver> {
  @override
  String? dropdownValue;

  Widget build(BuildContext context) {
    ref.watch(firestoredataprovider).getdatas;
    ref.watch(firestoredataprovider).deletedata;
    print("______________________________________________");
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            print("refresh");
            context.navigationtoscreen(child: DriversData(), isreplace: true);
          },
          child: const Text("Add Drivers")),
      body: Column(children: [
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: ref
                  .read(firestoredataprovider)
                  .getdatas(collection: "userdriver"),
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
                        child: InkWell(
                          onTap: () {
                            print("back to push page");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (builder) {
                              return UpdatePage(
                                data: data,
                              );
                            }));
                          },
                          child: ListTile(
                            title: Text(data['name']),
                            subtitle: FutureBuilder(
                                future: ref
                                    .read(firestoredataprovider)
                                    .getdatas(collection: "retaildata"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text("Error: ${snapshot.error}"));
                                  } else if (snapshot.hasData) {
                                    final datalist = snapshot.data;
                                    final data = datalist!.map((e) {
                                      return e["name"];
                                    }).toList();
                                    print(data.toString());

                                    print(data.runtimeType);
                                    print("needt o know");
                                    final dropdownprovider =
                                        StateProvider<String?>(
                                            (ref) => dropdownValue);
                                    return Consumer(builder: (context, ref, _) {
                                      ref.watch(dropdownprovider);

                                      return DropdownButton<String>(
                                        value: ref.watch(dropdownprovider),
                                        onChanged: ((value) {
                                          ref
                                              .read(dropdownprovider.notifier)
                                              .state = value;
                                        }),
                                        items: data
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      );
                                    });
                                  }
                                  return SizedBox();
                                }),
                            trailing: IconButton(
                                onPressed: () {
                                  ref.read(firestoredataprovider).deletedata(
                                      doc: data['id'],
                                      collection: "userdriver");
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
        )
      ]),
    );
  }
}

Widget builduser(Datamodel datamodel) {
  return ListTile(
    title: Text(datamodel.name),
  );
}

class DriversData extends ConsumerWidget {
  const DriversData({super.key, required});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("dataaa");
    print("+++++++++");
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
            onPressed: () {
              ref.read(firestoredataprovider.notifier).createdata(
                  name: driverdatacontroller.text, collection: "userdriver");

              ref
                  .read(firestoredataprovider)
                  .getdatas(collection: "userdriver");

              Navigator.pop(context);
            })
      ]),
    );
  }
}
