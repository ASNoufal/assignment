import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/infrastructure/core/provider/providers.dart';
import 'package:assignment/presentation/Login/Loginform.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:assignment/presentation/Login/const.dart';
import 'package:assignment/presentation/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signupform extends ConsumerWidget {
  const Signupform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = Authprovider();
    final email = TextEditingController();
    final password = TextEditingController();
    final data = ref.watch(authProvider);
    Enum? value = Enum.admin;
    final _formkey = GlobalKey<FormState>();

    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the email and password";
                      }
                      return null;
                    },
                    controller: email,
                    cursorColor: const Color.fromARGB(255, 107, 104, 104),
                    decoration: formfielddecoration("Email"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: password,
                      obscureText: true,
                      cursorColor: const Color.fromARGB(255, 107, 104, 104),
                      decoration: formfielddecoration("Password")),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                      onTap: () {
                        ref
                            .read(authProvider.notifier)
                            .signupemailandpassword(email.text, password.text);
                        // .then((value) => Navigator.pushReplacement(context,
                        //         MaterialPageRoute(builder: (builder) {
                        //       return HomePage();
                        //     })));
                      },
                      child: customisedbutton(context, "Signup"))
                ],
              ),
              auth.isloading
                  ? const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(),
            ]),
          ),
        ));
  }
}

enum Enum { admin, drivers, retailshop }
