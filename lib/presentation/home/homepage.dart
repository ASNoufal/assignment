import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:assignment/presentation/managingdetails/Drivers/Driver.dart';
import 'package:assignment/presentation/managingdetails/RetailStores/RetailStorescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
                labelColor: Colors.black,
                dividerColor: Colors.red[400],
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    child:
                        Text("Drivers", style: GoogleFonts.acme(fontSize: 25)),
                  ),
                  Tab(
                    child: Text("Retail Stores",
                        style: GoogleFonts.acme(fontSize: 25)),
                  )
                ]),
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
