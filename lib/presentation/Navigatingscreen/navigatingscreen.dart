import 'package:flutter/material.dart';

extension BuildContextExtention on BuildContext {
  navigationtoscreen({bool isreplace = false, required Widget child}) {
    if (isreplace == true) {
      Navigator.push(this, MaterialPageRoute(builder: (_) {
        return child;
      }));
    } else {
      Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) {
        return child;
      }));
    }
  }
}
