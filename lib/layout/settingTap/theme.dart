import 'package:flutter/material.dart';
import '../../../color_manager.dart';
ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromRGBO(5, 18, 56, 0.80),
    primary: Colors.grey[900]!,
    secondary: Colors.white!
  )
);
ThemeData lighttheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: ColorManager.colorOffwhite,
        primary: Colors.grey[900]!,
        secondary: Colors.grey[700]!
    )
);
ThemeMode themeMode = ThemeMode.light; // Default theme mode

toggleTheme() {

    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }