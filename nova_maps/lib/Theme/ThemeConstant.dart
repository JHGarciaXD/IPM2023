import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromARGB(255, 22, 11, 59);
const COLOR_ACCENT = Color.fromARGB(255, 49, 28, 120);

ThemeData lightTheme = ThemeData (
  brightness: Brightness.dark
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: COLOR_PRIMARY,
  backgroundColor: const Color.fromARGB(255, 102, 102, 102),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: COLOR_PRIMARY),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT),
    )
  )


);