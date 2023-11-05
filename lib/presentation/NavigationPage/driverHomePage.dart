import 'package:assignment/presentation/managingdetails/Drivers/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverHomePage extends ConsumerWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select the driver"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
          future: ref
              .read(firestoredataprovider)
              .getdatas(collection: "getdriverdatatodeliver"),
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
                    final data = datalist?[index];

                    return Card(
                      child: ListTile(
                        title: Text(data?['name']),
                      ),
                    );
                  });
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
