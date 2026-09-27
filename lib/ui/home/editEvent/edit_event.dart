import 'package:evently/fireStore/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/ui/widgets/custom_add_event_item.dart';
import 'package:evently/ui/widgets/custom_date_or_time_event.dart';
import 'package:evently/ui/widgets/custom_event_tabs.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/elevated_button_reuse.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formatDate = '';
  String formatTime = '';
  String selectedEventName = '';
  String selectedEventImage = '';
  bool _initialized = false;
  late Event event;

  final List<String> eventDarkImagesLists = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  final List<String> eventLightImagesLists = [
    AppAssets.sportLight,
    AppAssets.birthdayLight,
    AppAssets.meetingLight,
    AppAssets.bookClubLight,
    AppAssets.exLight,
  ];

  List<String> eventNamesLists = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      event = ModalRoute.of(context)!.settings.arguments as Event;
      _titleController = TextEditingController(text: event.eventTitle);
      _descController = TextEditingController(text: event.eventDescription);
      selectedIndex = (event.eventCatIndex - 1).clamp(0, 4);
      selectedDate = event.eventDate;
      selectedTime = TimeOfDay.fromDateTime(event.eventDate);
      formatDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
      formatTime = DateFormat("hh:mm a").format(selectedDate!);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    eventNamesLists = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibtion,
    ];
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final height = context.height;
    final width = context.width;

    selectedEventImage = themeProvider.isDark
        ? eventDarkImagesLists[selectedIndex]
        : eventLightImagesLists[selectedIndex];
    selectedEventName = eventNamesLists[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).shadowColor,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 20),
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.edit_event,
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAddEventItem(imagePth: selectedEventImage),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * .05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
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
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.01),
                CustomTextFormField(
                  controller: _titleController,
                  hinttext: AppLocalizations.of(context)!.event_title,
                  hintstyle: Theme.of(context).textTheme.bodyLarge,
                  fill: true,
                  filledColor: Theme.of(context).secondaryHeaderColor,
                  borderColor: Theme.of(context).shadowColor,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter event title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.01),
                CustomTextFormField(
                  controller: _descController,
                  hinttext: AppLocalizations.of(context)!.event_description,
                  hintstyle: Theme.of(context).textTheme.bodyLarge,
                  fill: true,
                  filledColor: Theme.of(context).secondaryHeaderColor,
                  borderColor: Theme.of(context).shadowColor,
                  maxline: 4,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter event description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                CustomDateOrTimeEvent(
                  iconOrImage: Icon(
                    Icons.date_range_outlined,
                    color: Theme.of(context).cardColor,
                    size: 25,
                  ),
                  eventDateOtTime: AppLocalizations.of(context)!.event_date,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : formatDate,
                  onPressed: chooseDate,
                ),
                SizedBox(height: height * 0.015),
                CustomDateOrTimeEvent(
                  iconOrImage: Icon(
                    Icons.access_time_outlined,
                    color: Theme.of(context).cardColor,
                    size: 25,
                  ),
                  eventDateOtTime: AppLocalizations.of(context)!.event_time,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : formatTime,
                  onPressed: chooseTime,
                ),
                SizedBox(height: height * 0.03),
                ElevatedButtonReuse(
                  ChildType: Text(
                    AppLocalizations.of(context)!.update_event,
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(color: AppColors.white),
                  ),
                  onpressed: updateEvent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
        formatDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
      });
    }
  }

  void chooseTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
        formatTime = time.format(context);
      });
    }
  }

  void updateEvent() async {
    if (_formKey.currentState!.validate() == true) {
      final updatedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      event.eventTitle = _titleController.text.trim();
      event.eventDescription = _descController.text.trim();
      event.eventName = selectedEventName;
      event.eventCatIndex = selectedIndex + 1;
      event.eventImage = selectedEventImage;
      event.eventDate = updatedDateTime;

      try {
        await FirebaseUtils.updateEvent(event);
        if (mounted) {
          ToastUtils.getFlutterToast(
            message: AppLocalizations.of(context)!.event_updated_successfully,
            backGroundColor: AppColors.lightGreen,
            textColor: AppColors.white,
            fontSize: 18,
          );
          Navigator.pop(context, true);
        }
      } catch (error) {
        ToastUtils.getFlutterToast(
          message: error.toString(),
          backGroundColor: AppColors.red,
          textColor: AppColors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 18,
        );
      }
    }
  }
}
