import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appThemeMode = ThemeMode.light;

  void changeAppThemeMode(ThemeMode newAppThemeMode) {
    if (appThemeMode == newAppThemeMode) {
      return;
    }
    appThemeMode = newAppThemeMode;
    notifyListeners();
  }

  bool get isDark => appThemeMode == ThemeMode.dark;
}
