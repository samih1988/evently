import 'package:evently/sharedPreference/preferences_helper.dart';
import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = PreferencesHelper.getLang();

  void changeAppLanguage(String newAppLanguage) {
    if (appLanguage == newAppLanguage) {
      return;
    }
    appLanguage = newAppLanguage;
    notifyListeners();
    PreferencesHelper.saveLang(newAppLanguage);
  }
}
