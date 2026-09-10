import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/widgets/custom_add_event_item.dart';
import 'package:evently/ui/widgets/custom_date_or_time_event.dart';
import 'package:evently/ui/widgets/custom_event_tabs.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/elevated_button_reuse.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_utilz.dart';

class AddEvent extends StatefulWidget {
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  var _fromkey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formateDate = '';
  String formateTime = '';
  String selectedEventName = '';
  String selectedEventImage = '';
  List<String> eventDarkImagesLists = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  List<String> eventLightImagesLists = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exLight,
  ];

  List<String> eventNamesLists = [];

  @override
  Widget build(BuildContext context) {
    eventNamesLists = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibtion,
    ];
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = context.height;
    var width = context.width;
    selectedEventImage = themeProvider.isDark
        ? eventDarkImagesLists[selectedIndex]
        : eventLightImagesLists[selectedIndex];
    selectedEventName = eventNamesLists[selectedIndex];
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
          AppLocalizations.of(context)!.add_event,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _fromkey,
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: height * .02,
              children: [
                CustomAddEventItem(imagePth: selectedEventImage),
                SizedBox(
                  height: height * .05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: CustomEventTabs(
                          isselected: selectedIndex == index,
                          eventName: eventNamesLists[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: width * .02),
                    itemCount: eventNamesLists.length,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextFormField(
                  hinttext: AppLocalizations.of(context)!.event_title,
                  hintstyle: Theme.of(context).textTheme.bodyLarge,
                  fill: true,
                  filledColor: Theme.of(context).secondaryHeaderColor,
                  borderColor: Theme.of(context).shadowColor,
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter event title";
                    }
                    return null;
                  },
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
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter event description";
                    }
                    return null;
                  },
                ),
                CustomDateOrTimeEvent(
                  iconOrImage: Icon(
                    Icons.date_range_outlined,
                    color: Theme.of(context).cardColor,
                    size: 25,
                  ),
                  eventDateOtTime: AppLocalizations.of(context)!.event_date,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : formateDate,
                  onPressed: choosedate,
                ),
                CustomDateOrTimeEvent(
                  iconOrImage: Icon(
                    Icons.access_time_outlined,
                    color: Theme.of(context).cardColor,
                    size: 25,
                  ),
                  eventDateOtTime: AppLocalizations.of(context)!.event_time,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : formateTime,
                  onPressed: choosetime,
                ),
                ElevatedButtonReuse(
                  ChildType: Text(
                    AppLocalizations.of(context)!.add_event,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  onpressed: addEvent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void choosedate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = date;
    if (selectedDate != null) {
      formateDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
    }
    setState(() {});
  }

  void choosetime() async {
    var choosetime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = choosetime;
    if (selectedTime != null) {
      formateTime = selectedTime!.format(context);
    }
    setState(() {});
  }

  void addEvent() {
    if (_fromkey.currentState!.validate() == true) {}
  }
}
