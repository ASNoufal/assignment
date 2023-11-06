import 'package:assignment/application/model/datamodel.dart';
import 'package:assignment/presentation/managingdetails/Drivers/updatepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:assignment/presentation/Navigatingscreen/navigatingscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

String? intial = "Select the store";

class Driver extends ConsumerStatefulWidget {
  const Driver({super.key});

  @override
  ConsumerState<Driver> createState() => _DriverState();
}

class _DriverState extends ConsumerState<Driver> {
  @override
  String? id;
  String? dropdownValue;
  String? dropdownname;
  String? lat;
  String? lon;

  @override
  Widget build(BuildContext context) {
    ref.watch(firestoredataprovider).getdatas;
    ref.watch(firestoredataprovider).deletedata;
    return Scaffold(
      backgroundColor: Colors.green[100],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
          onPressed: () {
            context.navigationtoscreen(
                child: const DriversData(), isreplace: true);
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
                        color: Colors.green[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (builder) {
                                return UpdatePage(
                                  data: data,
                                );
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Name: ${data['name'].toString()}',
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            ref
                                                .read(firestoredataprovider)
                                                .deletedata(
                                                    doc: data['id'],
                                                    collection: "userdriver");
                                          },
                                          icon:
                                              const Icon(CupertinoIcons.delete))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: ref
                                              .read(firestoredataprovider)
                                              .getdatas(
                                                  collection: "retaildata"),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Colors.green[100],
                                              ));
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      "Error: ${snapshot.error}"));
                                            } else if (snapshot.hasData) {
                                              final datalist = snapshot.data;
                                              final retaildata =
                                                  datalist!.map((e) {
                                                return e;
                                              }).toList();

                                              final dropdownprovider =
                                                  StateProvider<String?>(
                                                      (ref) => dropdownValue);
                                              return Consumer(
                                                  builder: (context, ref, _) {
                                                return DropdownButton<String>(
                                                  hint: const Text(
                                                    "Retailstore",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  value: ref
                                                      .watch(dropdownprovider),
                                                  onChanged: ((value) {
                                                    id = ref
                                                        .read(dropdownprovider
                                                            .notifier)
                                                        .state = value;
                                                  }),
                                                  items: retaildata.map<
                                                      DropdownMenuItem<
                                                          String>>((values) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: values['id'],
                                                      child:
                                                          Text(values['name']),
                                                    );
                                                  }).toList(),
                                                );
                                              });
                                            }
                                            return const SizedBox();
                                          }),
                                      const Spacer(),
                                      ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green[700]),
                                          onPressed: () async {
                                            var latandlon = await ref
                                                .read(firestoredataprovider
                                                    .notifier)
                                                .getdatafromtheid(
                                                    toGetthelatandlon: id!);

                                            await ref
                                                .read(firestoredataprovider)
                                                .createdata(
                                                  collection:
                                                      "getdriverdatatodeliver",
                                                  name: data['name'],
                                                  lat: latandlon['lat'],
                                                  lon: latandlon['lon'],
                                                  storename: latandlon['name'],
                                                );

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Added Succesfully")));
                                          },
                                          icon: const Icon(CupertinoIcons
                                              .arrow_down_doc_fill),
                                          label: const Text("Submit"))
                                    ],
                                  ),
                                ],
                              ),
                            )),
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
    final driverdatacontroller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
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
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
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
