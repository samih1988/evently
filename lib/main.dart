import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/sharedPreference/preferences_helper.dart';
import 'package:evently/ui/home/addEvent/add_event.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/login/login_Screen.dart';
import 'package:evently/ui/onboarding/onboarding_tabs.dart';
import 'package:evently/ui/register/register_Screen.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'ui/introductionScreen/introduction_screen.dart';

void main() async {
  // خطوة إجبارية لضمان عمل SharedPreferences قبل تشغيل واجهات التطبيق
  // خطوة إجبارية لضمان عمل الـ SharedPreferences قبل تشغيل الواجهات
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // تهيئة ملف الـ Helper وقراءة البيانات المخزنة فوراً في الذاكرة
  await PreferencesHelper.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.introductionRoutName: (context) => IntroductionScreen(),
        AppRoutes.onboardingRouteName: (context) => OnBoardingPage(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.addEventRouteName: (context) => AddEvent(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appThemeMode,
    );
  }
}
