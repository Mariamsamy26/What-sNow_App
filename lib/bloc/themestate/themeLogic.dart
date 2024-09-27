import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/bloc/themestate/themeState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLogic extends Cubit<ThemeState> {
  ThemeMode currentThemeMode = ThemeMode.light; // Initial theme mode

  ThemeLogic() : super(InitTheme()) {
    loadThemeFromPreferences();
  }

  void saveThemeToPreferences(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', themeMode == ThemeMode.light ? 'light' : 'dark');
  }

  void loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode') ?? 'light';
    if (savedTheme == 'dark') {
      themeSwitchToDark();
    } else {
      themeSwitchToLight();
    }
  }

  void themeSwitchToLight() {
    currentThemeMode = ThemeMode.light;
    saveThemeToPreferences(currentThemeMode);
    emit(LightTheme()); // Emit the light theme state
  }

  void themeSwitchToDark() {
    currentThemeMode = ThemeMode.dark;
    saveThemeToPreferences(currentThemeMode);
    emit(DarkTheme()); // Emit the dark theme state
  }

  void toggleTheme() {
    currentThemeMode = currentThemeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(currentThemeMode == ThemeMode.light ? LightTheme() : DarkTheme());
  }
}
