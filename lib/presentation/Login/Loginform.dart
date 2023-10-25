import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/presentation/Login/const.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loginform extends ConsumerWidget {
  const Loginform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = TextEditingController();
    final password = TextEditingController();
    ref.watch(authNotifierprovider);
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
                      return "Empty data";
                    } else {
                      return null;
                    }
                  },
                  controller: email,
                  cursorColor: const Color.fromARGB(255, 107, 104, 104),
                  decoration: formfielddecoration("Email"),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        print("empty dat");
                        return "Empty data";
                      } else {
                        return null;
                      }
                    },
                    controller: password,
                    obscureText: true,
                    cursorColor: const Color.fromARGB(255, 107, 104, 104),
                    decoration: formfielddecoration("Password")),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        ref.read(authNotifierprovider.notifier).login(
                            email: email.text.trim(), password: password.text);
                      }
                    },
                    child: customisedbutton(context, "Login"))
              ],
            ),
          ),
        ));
  }
}
