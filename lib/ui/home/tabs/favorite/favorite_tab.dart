import 'package:evently/ui/widgets/custom_item_event.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_utilz.dart';
import '../../../widgets/custom_text_form_field.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(height * .02),
        child: Column(
          spacing: height * .02,
          children: [
            CustomTextFormField(
              borderColor: Theme
                  .of(context)
                  .highlightColor,
              hinttext: AppLocalizations.of(context)!.search_for_event,
              hintstyle: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
              sufixIcon: Icon(
                Icons.search_outlined,
                color: Theme
                    .of(context)
                    .cardColor,
                size: 35,
              ),

            ),
            Expanded(child: ListView.separated(
                itemBuilder: (context, index) {
                  return CustomItemEvent();
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * .02,),
                itemCount: 10))
          ],
        ),
      ),
    );
  }
}
