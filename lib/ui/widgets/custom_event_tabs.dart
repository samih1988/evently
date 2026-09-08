import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';
import '../../utils/app_utilz.dart';

class CustomEventTabs extends StatelessWidget {
  bool isselected;
  String eventName;

  CustomEventTabs({
    super.key,
    required this.isselected,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = context.height;
    var width = context.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height * .012,
        horizontal: width * .06,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isselected
            ? Theme.of(context).cardColor
            : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      child: Text(
        eventName,
        style: isselected
            ? Theme.of(context).textTheme.displaySmall
            : Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
