import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/introductionScreen/theme_button_widget.dart';
import 'package:evently/ui/widgets/elevated_button_reuse.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'language_button_widget.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  String selected = '';
  late ThemeMode appMode;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    selected = languageProvider.appLanguage;
    appMode = themeProvider.appThemeMode;
    var height = context.height;
    var width = context.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: height * .02,
              children: [
                Image.asset("assets/images/intro_logo.png"),
                Image.asset("assets/images/introduction.png"),
                Column(
                  crossAxisAlignment: .start,
                  spacing: height * .02,
                  children: [
                    Text(
                      "Personalize Your Experience",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "Choose your preferred theme and \n language to get started with a \n comfortable,"
                      " tailored experience that suits your style.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w700,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Row(
                      spacing: width * .02,
                      children: [
                        LanguageButtonWidget(
                          text: AppLocalizations.of(context)!.english,
                          value: 'en',
                          languageProvider: languageProvider,
                          selected: selected,
                        ),

                        LanguageButtonWidget(
                          text: AppLocalizations.of(context)!.arabic,
                          value: 'ar',
                          languageProvider: languageProvider,
                          selected: selected,
                        ),
                      ],
                    ),
                  ],
                ),
                // theme button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w700,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    Row(
                      spacing: width * .02,
                      children: [
                        ThemeButtonWidget(
                          iconName: themeProvider.isDark
                              ? Icons.wb_sunny_outlined
                              : Icons.sunny,
                          value: ThemeMode.light,
                          themeProvider: themeProvider,
                          selected: appMode,
                        ),
                        ThemeButtonWidget(
                          iconName: themeProvider.isDark
                              ? Icons.dark_mode
                              : Icons.dark_mode_outlined,
                          value: ThemeMode.dark,
                          themeProvider: themeProvider,
                          selected: appMode,
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButtonReuse(
                  ChildType: Text(
                    AppLocalizations.of(context)!.lets_start,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  onpressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.onboardingRouteName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
