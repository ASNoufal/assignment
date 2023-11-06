import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:assignment/presentation/managingdetails/Drivers/Driver.dart';
import 'package:assignment/presentation/managingdetails/RetailStores/RetailStorescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          bottom: TabBar(
              dividerColor: Colors.green,
              indicatorColor: Colors.green[300],
              labelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text("Drivers", style: GoogleFonts.acme(fontSize: 25)),
                ),
                Tab(
                  child: Text("Retail Stores",
                      style: GoogleFonts.acme(fontSize: 25)),
                )
              ]),
          actions: [
            Consumer(builder: (context, ref, _) {
              return IconButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).signout();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) {
                      return const LoginPage();
                    }));
                  },
                  icon: const Icon(Icons.exit_to_app));
            })
          ],
        ),
        body: const Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: <Widget>[Driver(), RetailStore()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
