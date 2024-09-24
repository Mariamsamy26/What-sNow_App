import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/themestate/themeState.dart';

// Define the ThemeLogic class extending Cubit
class ThemeLogic extends Cubit<ThemeState> {
  // Store the current theme mode
  ThemeMode currentThemeMode = ThemeMode.light;

  ThemeLogic() : super(InitTheme());

  void themeSwitchToLight() {
    currentThemeMode = ThemeMode.light; // Update the current theme mode
    emit(LightTheme()); // Emit the light theme state
  }

  void themeSwitchToDark() {
    currentThemeMode = ThemeMode.dark; // Update the current theme mode
    emit(DarkTheme()); // Emit the dark theme state
  }

  void toggleTheme() {
    if (currentThemeMode == ThemeMode.light) {
      themeSwitchToDark();
    } else {
      themeSwitchToLight();
    }
  }
}
