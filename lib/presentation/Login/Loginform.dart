import 'package:assignment/presentation/Login/const.dart';
import 'package:flutter/material.dart';

class Loginform extends StatelessWidget {
  const Loginform({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 107, 104, 104),
              decoration: formfielddecoration("Email"),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
                obscureText: true,
                cursorColor: const Color.fromARGB(255, 107, 104, 104),
                decoration: formfielddecoration("Password")),
            const SizedBox(
              height: 50,
            ),
            customisedbutton(context, "Login")
          ],
        ),
      ),
    ));
  }
}
