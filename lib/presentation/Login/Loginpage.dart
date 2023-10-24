import 'package:assignment/presentation/Login/Loginform.dart';
import 'package:assignment/presentation/Login/Signupform.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: const Color.fromARGB(255, 153, 37, 29)),
        child: Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 181, 25, 13),
                      Colors.redAccent
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                            labelColor: Colors.black,
                            dividerColor: Colors.red[400],
                            indicatorColor: Colors.red,
                            tabs: [
                              Tab(
                                child: Text("Login",
                                    style: GoogleFonts.acme(fontSize: 25)),
                              ),
                              Tab(
                                child: Text("signup",
                                    style: GoogleFonts.acme(fontSize: 25)),
                              )
                            ]),
                        const Expanded(
                          child: TabBarView(
                            children: <Widget>[Loginform(), Signupform()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
