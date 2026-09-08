import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/widgets/custom_event_tabs.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_utilz.dart';
import '../../../widgets/custom_item_event.dart';
import '../../../widgets/custom_text_form_field.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventNamesList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibtion,
    ];
    var height = context.height;
    var width = context.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(height * .02),
        child: DefaultTabController(
          length: eventNamesList.length,
          child: Column(
            spacing: height * .02,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome_back,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge,
                      ),
                      Text(
                        "Samih  asaad",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge,
                      ),
                    ],
                  ),
                  Row(

                    children: [
                      IconButton(
                        onPressed: () {
                          if (themeProvider.appThemeMode == ThemeMode.dark) {
                            themeProvider.changeAppThemeMode(ThemeMode.light);
                          } else {
                            themeProvider.changeAppThemeMode(ThemeMode.dark);
                          }
                        },
                        icon: Icon(
                          themeProvider.isDark
                              ? Icons.dark_mode_outlined
                              : Icons.wb_sunny_outlined,
                          size: 25,
                          color: Theme
                              .of(context)
                              .cardColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (languageProvider.appLanguage == "en") {
                            languageProvider.changeAppLanguage("ar");
                          } else {
                            languageProvider.changeAppLanguage("en");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: height * .01,
                              horizontal: width * .02),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme
                                  .of(context)
                                  .cardColor
                          ),
                          child: Text(AppLocalizations.of(context)!.en,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displaySmall,),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // tabs
              TabBar(
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {

                  });
                },
                isScrollable: true,
                dividerColor: AppColors.transparentColor,
                indicatorColor: AppColors.transparentColor,
                labelPadding: EdgeInsets.symmetric(horizontal: width * .02),
                tabAlignment: TabAlignment.start,
                tabs: eventNamesList.map((eventName) {
                  return CustomEventTabs(isselected: selectedIndex ==
                      eventNamesList.indexOf(eventName), eventName: eventName);
                }).toList(),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return CustomItemEvent();
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: height * .02),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
