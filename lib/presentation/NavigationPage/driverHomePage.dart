import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:assignment/presentation/NavigationPage/geolocation.dart';
import 'package:assignment/presentation/managingdetails/Drivers/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverHomePage extends ConsumerWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double? lat;
    double? lon;
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authProvider.notifier).signout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) {
                  return const LoginPage();
                }));
              },
              icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: Colors.green[700],
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

                    return InkWell(
                      onTap: () {
                        lat = double.parse(data?['lat']);
                        lon = double.parse(data?['lon']);
                        print(lat);
                        print(lon);
                        print("1234567890");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Mymap(lat: lat, lon: lon);
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.green[300],
                        child: ListTile(
                            title: Text(
                              data?['name'],
                            ),
                            trailing: Text(data?["storename"])),
                      ),
                    );
                  });
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
