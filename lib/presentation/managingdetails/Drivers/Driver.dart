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
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Color color = Colors.white;

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
                        color: color,
                        shape: const LinearBorder(),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Name:- ${data['name'].toString().toUpperCase()}',
                                      style: GoogleFonts.harmattan(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          ref
                                              .read(firestoredataprovider)
                                              .deletedata(
                                                  doc: data['id'],
                                                  collection: "userdriver");
                                        },
                                        icon: const Icon(CupertinoIcons.delete))
                                  ],
                                ),
                                Row(
                                  children: [
                                    FutureBuilder(
                                        future: ref
                                            .read(firestoredataprovider)
                                            .getdatas(collection: "retaildata"),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
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
                                                hint: const Text("Retailstore"),
                                                value:
                                                    ref.watch(dropdownprovider),
                                                onChanged: ((value) {
                                                  id = ref
                                                      .read(dropdownprovider
                                                          .notifier)
                                                      .state = value;
                                                }),
                                                items: retaildata.map<
                                                    DropdownMenuItem<
                                                        String>>((values) {
                                                  print(id);
                                                  print("0909090");
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: values['id'],
                                                    child: Text(values['name']),
                                                  );
                                                }).toList(),
                                              );
                                            });
                                          }
                                          return const SizedBox();
                                        }),
                                    const Spacer(),
                                    ElevatedButton.icon(
                                        onPressed: () async {
                                          print(id);
                                          print("ididididididididid");
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

                                          print("////");
                                          ////////
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Added Succesfully")));
                                        },
                                        icon: const Icon(
                                            CupertinoIcons.arrow_down_doc_fill),
                                        label: const Text("Submit"))
                                  ],
                                ),
                              ],
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
