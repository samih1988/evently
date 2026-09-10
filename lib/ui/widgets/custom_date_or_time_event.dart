import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../utils/app_utilz.dart';

class CustomDateOrTimeEvent extends StatelessWidget {
  Widget iconOrImage;
  String eventDateOtTime;
  String chooseDateOrTime;
  VoidCallback onPressed;

  CustomDateOrTimeEvent({super.key, required this.iconOrImage,
    required this.eventDateOtTime, required this.chooseDateOrTime,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Row(
      spacing: width * .02,
      children: [
        iconOrImage,
        Text(eventDateOtTime, style: Theme
            .of(context)
            .textTheme
            .headlineMedium,),
        Spacer(),
        TextButton(onPressed: onPressed, child: Text(chooseDateOrTime,
          style: Theme
              .of(context)
              .textTheme
              .titleLarge!
              .copyWith(
              decorationColor: Theme
                  .of(context)
                  .cardColor,
              decoration: TextDecoration.underline
          ),))
      ],
    );
  }
}
