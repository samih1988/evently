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
      padding: EdgeInsets.symmetric(
        vertical: height * .01,
        horizontal: height * .01,
      ),
      height: height * .25decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme
            .of(context)
            .shadowColor, width: 2),
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
        mainAxisAlignment: .spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: height * .01,
              horizontal: height * .01,
            ),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme
                    .of(context)
                    .shadowColor,
                width: 2,
              ),
            ),
            child: Text(
              "21 june",
              style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(

              horizontal: height * .02,
            ),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme
                    .of(context)
                    .shadowColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "21 june",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ),
                IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_outline,),
                  color: Theme
                      .of(context)
                      .cardColor,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
