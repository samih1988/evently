import 'package:evently/fireStore/firebase_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/ui/widgets/elevated_button_reuse.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_utilz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../model/my_user.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/toast_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isloading = false;

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: height * .02,
              children: [
                Image.asset(AppAssets.onBoardLogo),
                Text(
                  AppLocalizations.of(context)!.login_account,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall,
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
                    final bool emailValid = RegExp(
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
                  keyboradtype: TextInputType.visiblePassword,
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
                // forget Password
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // navigte to reset password
                    },
                    child: Text(
                      '${AppLocalizations.of(context)!.forget_password} ?',
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
                ),
                // login button
                ElevatedButtonReuse(
                  ChildType: isloading
                      ? CircularProgressIndicator(
                    backgroundColor: AppColors.lightGreen,
                  )
                      : Text(
                    AppLocalizations.of(context)!.login,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                  ),
                  onpressed: login,
                ),
                // sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ${AppLocalizations.of(context)!.dont_have_account} ',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.registerRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
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
                  background: Theme
                      .of(
                    context,
                  )
                      .bottomNavigationBarTheme
                      .backgroundColor,
                  ChildType: Row(
                    spacing: width * .04,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.googleLogo),
                      Text(
                        "Login With Google",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge,
                      ),
                    ],
                  ),
                  onpressed: loginWithGoogle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginWithGoogle() async {
    try {
      isloading = true;
      setState(() {});

      // 1. تهيئة حزمة جوجل للإصدار الجديد
      await GoogleSignIn.instance.initialize();

      // 2. استخدام authenticate() بدلاً من signIn()
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn.instance.authenticate();

      if (googleUser == null) {
        isloading = false;
        setState(() {});
        return;
      }

      // 3. جلب الـ authentication
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // 4. إنشاء الـ Credential بـ idToken فقط للفايربيز
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 5. تسجيل الدخول في الفايربيز
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        MyUser? myUser = await FirebaseUtils.getUser(firebaseUser.uid);

        if (myUser == null) {
          myUser = MyUser(
            id: firebaseUser.uid,
            name: firebaseUser.displayName ?? "No Name",
            email: firebaseUser.email ?? "",
          );
          await FirebaseUtils.addUserTOFireStore(myUser);
        }

        if (!mounted) return;
        var userProvide = Provider.of<UserProvider>(context, listen: false);
        userProvide.updateMyUser(myUser);

        isloading = false;
        setState(() {});

        ToastUtils.getFlutterToast(
          message: "login successfully",
          backGroundColor: Theme
              .of(context)
              .cardColor,
          textColor: AppColors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 18,
        );

        Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
      }
    } catch (e) {
      isloading = false;
      setState(() {});
      print("Google Sign In Error: $e");
      ToastUtils.getFlutterToast(
        message: e.toString(),
        backGroundColor: AppColors.red,
        textColor: AppColors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 18,
      );
    }
  }

  void login() async {
    if (formKey.currentState!.validate() == true) {
      try {
        isloading = true;
        setState(() {});

        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);

        var user = await FirebaseUtils.getUser(credential.user?.uid ?? "");
        if (user == null) {
          isloading = false;
          setState(() {});
          return;
        }

        if (!mounted) return;
        var userProvide = Provider.of<UserProvider>(context, listen: false);
        userProvide.updateMyUser(user);

        isloading = false;
        setState(() {});

        ToastUtils.getFlutterToast(
          message: "login successfully",
          backGroundColor: Theme
              .of(context)
              .cardColor,
          textColor: AppColors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 18,
        );

        Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
      } on FirebaseAuthException catch (e) {
        isloading = false;
        setState(() {});

        if (e.code == 'invalid-credential') {
          ToastUtils.getFlutterToast(
            message: 'the email or password is incorrect',
            backGroundColor: AppColors.red,
            textColor: AppColors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 18,
          );
        } else if (e.code == 'network-request-failed') {
          ToastUtils.getFlutterToast(
            message: 'no network',
            backGroundColor: AppColors.red,
            textColor: AppColors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 18,
          );
        }
      } catch (e) {
        isloading = false;
        setState(() {});

        ToastUtils.getFlutterToast(
          message: e.toString(),
          backGroundColor: AppColors.red,
          textColor: AppColors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 18,
        );
      }
    }
  }
}