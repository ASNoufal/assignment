import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/infrastructure/core/provider/providers.dart';
import 'package:assignment/presentation/Login/Loginform.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:assignment/presentation/Login/const.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Signupform extends ConsumerWidget {
  const Signupform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = TextEditingController();
    final password = TextEditingController();
    final data = ref.watch(authNotifierprovider);
    Enum? value = Enum.admin;
    final _formkey = GlobalKey<FormState>();

    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
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
                TextFormField(
                    obscureText: true,
                    cursorColor: const Color.fromARGB(255, 107, 104, 104),
                    decoration: formfielddecoration("Reenter Password")),
                const SizedBox(
                  height: 50,
                ),
                // neeed to update from here
                DropdownButtonFormField<Enum>(
                    value: value,
                    items: const [
                      DropdownMenuItem(value: Enum.admin, child: Text("Admin")),
                      DropdownMenuItem(
                        value: Enum.drivers,
                        child: Text("SalesMan"),
                      ),
                      DropdownMenuItem(
                        value: Enum.retailshop,
                        child: Text("Retailer"),
                      ),
                    ],
                    onChanged: (Enum? newvalue) {
                      value = newvalue;
                      print(value);
                    }),

                GestureDetector(
                    onTap: () {
                      ref.read(authNotifierprovider.notifier).signup(
                          email: email.text.trim(), password: password.text);
                    },
                    child: customisedbutton(context, "Signup"))
              ],
            ),
          ),
        ));
  }
}

enum Enum { admin, drivers, retailshop }
