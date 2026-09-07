import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';

class ThemeButtonWidget extends StatelessWidget {
  ThemeMode selected;
  AppThemeProvider themeProvider;
  ThemeMode value;
  IconData iconName;

  ThemeButtonWidget({
    super.key,
    required this.iconName,
    required this.value,
    required this.themeProvider,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedButton = selected == value;
    return GestureDetector(
      onTap: () => themeProvider.changeAppThemeMode(value),
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
        child: Icon(
          (iconName),
          color: selectedButton
              ? Theme.of(context).floatingActionButtonTheme.foregroundColor
              : Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
