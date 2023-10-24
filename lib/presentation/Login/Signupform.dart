import 'package:assignment/presentation/Login/const.dart';
import 'package:flutter/material.dart';

class Signupform extends StatelessWidget {
  const Signupform({super.key});

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
              height: 30,
            ),
            TextFormField(
                obscureText: true,
                cursorColor: const Color.fromARGB(255, 107, 104, 104),
                decoration: formfielddecoration("Password")),
            SizedBox(
              height: 25,
            ),
            TextFormField(
                obscureText: true,
                cursorColor: const Color.fromARGB(255, 107, 104, 104),
                decoration: formfielddecoration("Reenter Password")),
            const SizedBox(
              height: 50,
            ),
            DropdownButtonFormField(value: User.values,
              items: const [DropdownMenuItem( value: User.drivers,child: Text("SalesMan"),),DropdownMenuItem(value:User.retailshop,child: Text("Retailer"),),], onChanged: (value){

            })
            customisedbutton(context, "Signup")
          ],
        ),
      ),
    ));
  }
}
enum User{
  drivers,
  retailshop

}