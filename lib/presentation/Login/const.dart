import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration formfielddecoration(String name) {
  return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)),
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
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 42, 143, 54),
              Colors.green[300]!
            ]),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            data,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1),
          ),
        )),
  );
}
