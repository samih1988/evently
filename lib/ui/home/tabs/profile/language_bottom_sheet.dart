import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var width = context.width;
    var height = context.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * .04,
        horizontal: width * .04,
      ),
      child: Column(
        spacing: height * .03,
        crossAxisAlignment: .stretch,
        mainAxisSize: .min,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeAppLanguage("en");
            },
            child: languageProvider.appLanguage == "en"
                ? _getSelectedItem(
                    language: AppLocalizations.of(context)!.english,
                  )
                : _getUnSelectedItem(
                    language: AppLocalizations.of(context)!.english,
                  ),
          ),
          InkWell(
            onTap: () {
              languageProvider.changeAppLanguage("ar");
            },
            child: languageProvider.appLanguage == "ar"
                ? _getSelectedItem(
                    language: AppLocalizations.of(context)!.arabic,
                  )
                : _getUnSelectedItem(
                    language: AppLocalizations.of(context)!.arabic,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _getSelectedItem({required String language}) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(language, style: Theme.of(context).textTheme.headlineMedium),
        Icon(Icons.check, color: AppColors.mainColor, size: 30),
      ],
    );
  }

  Widget _getUnSelectedItem({required String language}) {
    return Text(language, style: Theme.of(context).textTheme.headlineMedium);
  }
}
