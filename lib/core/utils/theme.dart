import 'package:flutter/material.dart';

class MyAppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.blueGrey,
    );
  }
}
