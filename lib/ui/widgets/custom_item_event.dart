import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utilz.dart';

class CustomItemEvent extends StatelessWidget {
  CustomItemEvent({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: height * .01, left: height * .01),
      height: height * .22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).highlightColor, width: 2),
        image: DecorationImage(
          image: AssetImage(
            themeProvider.isDark
                ? AppAssets.birthdayDark
                : AppAssets.birthdayLight,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: height * .01,
              horizontal: height * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).highlightColor,
                width: 2,
              ),
            ),
            child: Text(
              "21 june",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
