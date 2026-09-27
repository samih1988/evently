import 'package:evently/fireStore/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
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

  String _getMatchingImage(Event event, bool isDark) {
    int catIdx = event.eventCatIndex - 1;
    if (catIdx >= 0 && catIdx < eventDarkImagesLists.length) {
      return isDark
          ? eventDarkImagesLists[catIdx]
          : eventLightImagesLists[catIdx];
    }
    return event.eventImage;
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDark;
    final height = context.height;
    final width = context.width;
    final displayImage = _getMatchingImage(event, isDark);

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
          AppLocalizations.of(context)!.event_details,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final updated = await Navigator.pushNamed(
                context,
                AppRoutes.editEventRouteName,
                arguments: event,
              );
              if (updated == true && mounted) {
                setState(() {});
              }
            },
            icon: Icon(Icons.edit_outlined, color: Theme.of(context).cardColor),
          ),
          IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context, event);
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.red,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Event Banner Image
              Container(
                height: height * 0.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: AssetImage(displayImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // Event Title
              Text(
                event.eventTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),

              // Date & Time Card
              Container(
                padding: EdgeInsets.all(width * 0.035),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).shadowColor,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).cardColor,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM').format(event.eventDate),
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('hh:mm a').format(event.eventDate),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // Description Title
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: height * 0.012),

              // Description Box
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  event.eventDescription,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).shadowColor, width: 1.5),
          ),
          title: Text(
            AppLocalizations.of(context)!.delete_event,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            AppLocalizations.of(context)!.delete_event_confirm,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext); // Close dialog
                try {
                  await FirebaseUtils.deleteEvent(event.id);
                  if (mounted) {
                    ToastUtils.getFlutterToast(
                      message: AppLocalizations.of(
                        context,
                      )!.event_deleted_successfully,
                      backGroundColor: AppColors.lightGreen,
                      textColor: AppColors.white,
                      fontSize: 16,
                    );
                    Navigator.pop(context); // Go back from details screen
                  }
                } catch (e) {
                  ToastUtils.getFlutterToast(
                    message: e.toString(),
                    backGroundColor: AppColors.red,
                    textColor: AppColors.white,
                    fontSize: 16,
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.delete),
            ),
          ],
        );
      },
    );
  }
}
