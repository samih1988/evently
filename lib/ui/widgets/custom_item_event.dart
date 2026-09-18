import 'package:evently/fireStore/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_utilz.dart';

class CustomItemEvent extends StatelessWidget {
  Event event;

  CustomItemEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return
      Container(
      padding: EdgeInsets.symmetric(
        vertical: height * .01,
        horizontal: height * .01,
      ),
      height: height * .25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme
            .of(context)
            .shadowColor, width: 2),
        image: DecorationImage(
          image: AssetImage(event.eventImage),
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
              DateFormat('dd MMM').format(event.eventDate).toString(),
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
                    event.eventTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ),
                IconButton(nPressed: () {
                    FirebaseUtils.updateIsFavourite(event)
                        .then((value) {
                          return ToastUtils.getFlutterToast(
                            message: "updated successfully",
                            backGroundColor: AppColors.lightGreen,
                            textColor: AppColors.white,
                            gravity: .BOTTOM,
                            fontSize: 18,
                          );
                        })
                        .catchError((err) {
                          return ToastUtils.getFlutterToast(
                            message: err.toString(),
                            backGroundColor: AppColors.red,
                            textColor: AppColors.white,
                            gravity: .BOTTOM,
                            fontSize: 18,
                          );
                        });
                  },
                  icon: event.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_outline),
                  ccolor: Theme
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
