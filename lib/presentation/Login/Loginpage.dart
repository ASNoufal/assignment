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
      backgroundColor: Colors.green[100],
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Color.fromARGB(255, 30, 125, 52)),
        child: Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 44, 91, 37), Colors.green],
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
                            dividerColor: Colors.green[300],
                            indicatorColor: Colors.green[700],
                            tabs: [
                              Tab(
                                child: Text("Login",
                                    style: GoogleFonts.roboto(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Tab(
                                child: Text("Signup",
                                    style: GoogleFonts.roboto(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
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
