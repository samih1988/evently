import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = "en";

  void changeAppLanguage(String newAppLanguage) {
    if (appLanguage == newAppLanguage) {
      return;
    }
    appLanguage = newAppLanguage;
    notifyListeners();
  }
}
