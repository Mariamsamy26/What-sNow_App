import 'package:flutter/material.dart';
import '../../../color_manager.dart';
ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    // background: ColorManager.colorblueblack,
    primary: ColorManager.colorblueblack,
    secondary: ColorManager.colorOffwhite
  )
);
ThemeData lighttheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        // background: ColorManager.colorOffwhite,
        primary: ColorManager.colorOffwhite,
        secondary: ColorManager.colorblueblack
    )
);
ThemeMode themeMode = ThemeMode.light; // Default theme mode

toggleTheme() {

    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }