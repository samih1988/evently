import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/elevated_button_reuse.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.transparentColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: height * .02,
              children: [
                Image.asset(AppAssets.onBoardLogo),
                Text(
                  AppLocalizations.of(context)!.create_account,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall,
                ),
                // name
                CustomTextFormField(
                  borderColor: Theme
                      .of(context)
                      .highlightColor,
                  hinttext: AppLocalizations.of(context)!.enter_name,
                  hintstyle: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.lightGrey,
                  ),
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "Please enter an name";
                    }

                    return null;
                  },
                ),
                // email textField form
                CustomTextFormField(
                  keyboradtype: TextInputType.emailAddress,
                  borderColor: Theme
                      .of(context)
                      .highlightColor,
                  hinttext: AppLocalizations.of(context)!.enter_mail,
                  hintstyle: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.lightGrey,
                  ),
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "Please enter an email";
                    }
                    final bool emailValid =
                    RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                // password textField form
                CustomTextFormField(
                  keyboradtype: TextInputType.phone,
                  obscuretext: true,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                  borderColor: Theme
                      .of(context)
                      .highlightColor,
                  hinttext: AppLocalizations.of(context)!.enter_password,
                  hintstyle: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: AppColors.lightGrey,
                  ),
                  sufixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.lightGrey,
                  ),
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "Please enter an password";
                    }
                    if (text.length < 6) {
                      return " password must more than 6 numbers";
                    }
                    return null;
                  },
                ),
                // re enter password
                CustomTextFormField(
                  keyboradtype: TextInputType.phone,
                  obscuretext: true,

                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,
                  borderColor: Theme
                      .of(context)
                      .highlightColor,
                  hinttext: AppLocalizations.of(context)!.confirm_password,
                  hintstyle: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: AppColors.lightGrey,
                  ),
                  sufixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.lightGrey,
                  ),
                  controller: rePasswordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "Please enter an password";
                    }
                    if (text != passwordController.text) {
                      return " password dosent match";
                    }

                    return null;
                  },
                ),

                // login button
                ElevatedButtonReuse(
                  ChildType: Text(
                    AppLocalizations.of(context)!.create_account,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                  ),
                  onpressed: signUp,
                ),
                // sign up
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      ' ${AppLocalizations.of(context)!.alreay_account} ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        // navigte to sign up password
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Theme
                              .of(context)
                              .dividerColor,
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
                        color: Theme
                            .of(context)
                            .focusColor,
                        indent: width * .02,
                        endIndent: width * .04,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelLarge,
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme
                            .of(context)
                            .focusColor,
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                    ],
                  ),
                  onpressed: () {},
                  background: Theme
                      .of(
                    context,
                  )
                      .bottomNavigationBarTheme
                      .backgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState!.validate() == true) {

    }
  }
}
