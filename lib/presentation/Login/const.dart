import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration formfielddecoration(String name) {
  return InputDecoration(
      focusedBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      labelText: name,
      labelStyle:
          GoogleFonts.acme(fontSize: 20, letterSpacing: 1, color: Colors.grey));
}

Widget customisedbutton(BuildContext context, String data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        height: 60,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 181, 25, 13), Colors.redAccent]),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            data,
            style: GoogleFonts.acme(
                fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1),
          ),
        )),
  );
}
