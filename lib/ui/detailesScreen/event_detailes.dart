import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../widgets/custom_add_event_item.dart';
import '../widgets/custom_text_form_field.dart';

class EventDetailes extends StatelessWidget {
  const EventDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(width: 2, color: Theme.of(context).shadowColor),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          CustomAddEventItem(imagePth: AppAssets.sportDark),
          Text("data", style: Theme.of(context).textTheme.displayLarge),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: BoxBorder.all(
                width: 2,
                color: Theme.of(context).shadowColor,
              ),
              color: Theme.of(context).secondaryHeaderColor,
            ),
            child: Row(
              children: [
                Icon(Icons.date_range_outlined),
                Column(children: [Text("date"), Text("time")]),
              ],
            ),
          ),
          Text(
            AppLocalizations.of(context)!.description,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          CustomTextFormField(
            hinttext: AppLocalizations.of(context)!.event_description,
            hintstyle: Theme.of(context).textTheme.bodyLarge,
            fill: true,
            filledColor: Theme.of(context).secondaryHeaderColor,
            borderColor: Theme.of(context).shadowColor,
            maxline: 3,
          ),
        ],
      ),
    );
  }
}
