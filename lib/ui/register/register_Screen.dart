import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/elevated_button_reuse.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.transparentColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Form(
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: height * .02,
            children: [
              Image.asset(AppAssets.onBoardLogo),
              Text(
                AppLocalizations.of(context)!.create_account,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // name
              CustomTextFormField(
                borderColor: Theme.of(context).highlightColor,
                hinttext: AppLocalizations.of(context)!.enter_name,
                hintstyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.lightGrey,
                ),
              ),
              // email textField form
              CustomTextFormField(
                borderColor: Theme.of(context).highlightColor,
                hinttext: AppLocalizations.of(context)!.enter_mail,
                hintstyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.lightGrey,
                ),
              ),
              // password textField form
              CustomTextFormField(
                style: Theme.of(context).textTheme.bodySmall,
                borderColor: Theme.of(context).highlightColor,
                hinttext: AppLocalizations.of(context)!.enter_password,
                hintstyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Icon(
                  Icons.lock_open_outlined,
                  color: AppColors.lightGrey,
                ),
                sufixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.lightGrey,
                ),
              ),
              // re enter password
              CustomTextFormField(
                style: Theme.of(context).textTheme.bodySmall,
                borderColor: Theme.of(context).highlightColor,
                hinttext: AppLocalizations.of(context)!.confirm_password,
                hintstyle: Theme.of(context).textTheme.bodyLarge,
                prefixIcon: Icon(
                  Icons.lock_open_outlined,
                  color: AppColors.lightGrey,
                ),
                sufixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.lightGrey,
                ),
              ),

              // login button
              ElevatedButtonReuse(
                ChildType: Text(
                  AppLocalizations.of(context)!.create_account,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                onpressed: () {},
              ),
              // sign up
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    ' ${AppLocalizations.of(context)!.alreay_account} ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // navigte to sign up password
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ],
              ),
              //or
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).focusColor,
                      indent: width * .02,
                      endIndent: width * .04,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).focusColor,
                      indent: width * .04,
                      endIndent: width * .02,
                    ),
                  ),
                ],
              ),
              // login with google
              ElevatedButtonReuse(
                ChildType: Row(
                  spacing: width * .04,
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset(AppAssets.googleLogo),
                    Text(
                      AppLocalizations.of(context)!.sign_up_google,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                onpressed: () {},
                background: Theme.of(
                  context,
                ).bottomNavigationBarTheme.backgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
