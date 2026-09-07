import 'package:evently/ui/home/tabs/profile/widgets/profile_user_chosing.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_assets.dart';
import 'language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themProvider = Provider.of<AppThemeProvider>(context);
    var height = context.height;
    var width = context.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .06,
          vertical: height * .04,
        ),
        child: Column(
          spacing: height * .02,

          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.profileImage),
            ),
            Text(
              "Samih Asaad",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "samihasaad65@gmail.com",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ProfileUserChosing(
              textName: AppLocalizations.of(context)!.dark_mode,
              iconName: SwitchTheme(
                data: SwitchThemeData(
                  thumbIcon: WidgetStateProperty.all(
                    Icon(Icons.circle, size: 35, color: AppColors.white),
                  ),
                ),
                child: Switch(
                  activeTrackColor: AppColors.mainLightColor,
                  inactiveTrackColor: AppColors.superLightGrey,

                  trackOutlineColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ),

                  value: themProvider.isDark,
                  onChanged: (value) {
                    themProvider.changeAppThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
            ),

            InkWell(
              onTap: () {
                _showBottomModal();
              },
              child: ProfileUserChosing(
                textName: AppLocalizations.of(context)!.language,
                iconName: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),

            ProfileUserChosing(
              textName: AppLocalizations.of(context)!.logout,
              iconName: Icon(Icons.logout_outlined, color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomModal() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }
}
