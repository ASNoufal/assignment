import 'package:assignment/domain/authfailures/authfailures.dart';
import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/domain/stateauth/authentication_state.dart';
import 'package:assignment/presentation/Login/const.dart';
import 'package:assignment/presentation/NavigationPage/driverHomePage.dart';
import 'package:assignment/presentation/NavigationPage/geolocation.dart';
import 'package:assignment/presentation/home/homepage.dart';
import 'package:assignment/presentation/managingdetails/RetailStores/RetailStorescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Loginform extends ConsumerWidget {
  const Loginform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = TextEditingController();
    final password = TextEditingController();
    final authnotifier = ref.watch(authProvider);
    final _formkey = GlobalKey<FormState>();
    final validator = ref.watch(userloginformstate).form.email;
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "empty data";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        ref.read(userloginformstate.notifier).setemail(value!);
                      },
                      controller: email,
                      cursorColor: const Color.fromARGB(255, 107, 104, 104),
                      decoration: formfielddecoration("Email"),
                    ),
                    if (validator.errormessage.isNotEmpty &&
                        validator.errormessage != null)
                      Text(
                        validator.errormessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "emailandpassword are wrong";
                          }
                          return null;
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
                            ref
                                .read(authProvider.notifier)
                                .loginwithemailandpassword(
                                    email.text, password.text)
                                .then((value) {
                              if (FirebaseAuth.instance.currentUser!.uid ==
                                  "n7jvYfM2KSV4ObQV5uxiTiFsIY22") {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return const HomePage();
                                }));
                              } else {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return const DriverHomePage();
                                  // mymap();
                                }));
                              }
                            });
                          }
                        },
                        child: customisedbutton(context, "Login"))
                  ],
                ),
                authnotifier.isloading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ));
  }
}
