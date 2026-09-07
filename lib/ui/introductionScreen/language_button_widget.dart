import 'package:flutter/material.dart';

import '../../providers/app_language_provider.dart';

class LanguageButtonWidget extends StatelessWidget {
  String selected;
  AppLanguageProvider languageProvider;
  String value;
  String text;

  LanguageButtonWidget({
    super.key,
    required this.text,
    required this.value,
    required this.languageProvider,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedButton = selected == value;
    return GestureDetector(
      onTap: () => languageProvider.changeAppLanguage(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selectedButton
              ? Theme.of(context).floatingActionButtonTheme.backgroundColor
              : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: selectedButton
              ? Theme.of(context).textTheme.displaySmall
              : Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
