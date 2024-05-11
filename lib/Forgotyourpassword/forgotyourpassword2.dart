import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/validator.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../models/api_services.dart';
import '../models/resset_password_request_model.dart';

class Forgotyourpassword2 extends StatefulWidget {
  const Forgotyourpassword2({
    super.key,
    required this.email,
  });
  final String email;
  @override
  State<Forgotyourpassword2> createState() => Forgotyourpassword2state();
}

class Forgotyourpassword2state extends State<Forgotyourpassword2> {
  final _newpasswordController = TextEditingController();
  final _confirmnewpasswordController = TextEditingController();
  final _pinController = TextEditingController();
  static GlobalKey<FormState> forgotyourpassword2 = GlobalKey();
  static bool state = false;
  static bool state2 = false;
  static bool state3 = false;
  static bool hidetext = true;
  static bool hidetext2 = true;

  @override
  void initState() {
    super.initState();
    _newpasswordController.addListener(() {
      final isnewpasswordValid =
          validator.password(_newpasswordController.value.text);
      if (isnewpasswordValid != state) {
        setState(() {
          state = isnewpasswordValid;
        });
      }
      ;
    });

    _confirmnewpasswordController.addListener(() {
      final isnewpasswordValid =
          validator.password(_confirmnewpasswordController.value.text);
      if (isnewpasswordValid != state2) {
        setState(() {
          state2 = isnewpasswordValid;
        });
      }
      ;
    });

    _pinController.addListener(() {
      final isPinValid = Fieldvalidator.isPin(_pinController.value.text);
      if (isPinValid != state3) {
        setState(() {
          state3 = isPinValid;
        });
      }
    });
  }

  @override
  void dispose() {
    _newpasswordController.dispose();
    _confirmnewpasswordController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image : DecorationImage(image: AssetImage("assets/images/Shape.png"), fit: BoxFit.cover),
          ),
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 650,
            width: 456,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ColorPalette.SH_Grey100,
            ),
            child: ListView(physics: const ClampingScrollPhysics(), children: [
              WidgetsModels.Container_widget(
                  null,
                  null,
                  Alignment.center,
                  const EdgeInsets.only(bottom: 20 , top: 20),
                  null,
                  Image.asset(Path.LogoImg)),
              WidgetsModels.Container_widget(
                  null,
                  30,
                  Alignment.center,
                  null,
                  null,
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.montserrat(
                        color: ColorPalette.backgroundcolor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  )),
              WidgetsModels.Container_widget(
                  null,
                  20,
                  Alignment.center,
                  null,
                  null,
                  Text(
                    'You can change your password now ',
                    style: GoogleFonts.montserrat(
                        color: ColorPalette.backgroundcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )),
              Form(
                  key: forgotyourpassword2,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: WidgetsModels.customTTF_title(
                            'New Password',
                            null,
                            _newpasswordController,
                            TextInputType.visiblePassword,
                            Fieldvalidator.validatepassword,
                            Icon(
                              FluentIcons.key_20_regular,
                              color: ColorPalette.backgroundcolor,
                              size: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidetext = !hidetext;
                                });
                              },
                              child: hidetext
                                  ? Icon(
                                      FluentIcons.eye_off_24_filled,
                                      color: ColorPalette.backgroundcolor,
                                    )
                                  : Icon(
                                      FluentIcons.eye_24_filled,
                                      color: ColorPalette.backgroundcolor,
                                    ),
                            ),
                            hidetext,
                            null),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: WidgetsModels.customTTF_title(
                            'confirm Password',
                            null,
                            _confirmnewpasswordController,
                            TextInputType.visiblePassword,
                            Fieldvalidator.validatepassword,
                            Icon(
                              FluentIcons.key_20_regular,
                              color: ColorPalette.backgroundcolor,
                              size: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidetext2 = !hidetext2;
                                });
                              },
                              child: hidetext2
                                  ? Icon(
                                      FluentIcons.eye_off_24_filled,
                                      color: ColorPalette.backgroundcolor,
                                    )
                                  : Icon(
                                      FluentIcons.eye_24_filled,
                                      color: ColorPalette.backgroundcolor,
                                    ),
                            ),
                            hidetext2,
                            null),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: WidgetsModels.customTTF_title(
                            "Code pin",
                            null,
                            _pinController,
                            TextInputType.number,
                            Fieldvalidator.validatePinCode,
                            Icon(
                              FluentIcons.lock_shield_24_regular,
                              color: ColorPalette.backgroundcolor,
                            ),
                            null,
                            false,
                            6),
                      ),
                    ],
                  )),
              if (Fieldvalidator.isPin(_pinController.value.text) &&
                  validator.password(_newpasswordController.value.text) &&
                  validator.password(_confirmnewpasswordController.value.text) &&
                  (_confirmnewpasswordController.value.text ==
                      _newpasswordController.value.text))
                GestureDetector(
                    onTap: () async {
                      RessetPasswordRequestModel ForgotPassword =
                          RessetPasswordRequestModel(
                              email: widget.email,
                              otp: _pinController.value.text,
                              password: _newpasswordController.value.text);
                      var response = await APISERVICES()
                          .RessetPassword(ForgotPassword)
                          .catchError((error) {
                        print(error);
                      });
                      if (response != null) {
                        print(response);
                      }
                      Navigator.pushReplacementNamed(context, "PasswordChanged");
                    },
                    child: WidgetsModels.Container_widget(
                      null,
                      50,
                      Alignment.center,
                      const EdgeInsets.symmetric(horizontal: 30 , vertical: 20),
                      BoxDecoration(
                        color: ColorPalette.backgroundcolor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      Text(
                        'Reset Password',
                        style: GoogleFonts.montserrat(
                            color: ColorPalette.SH_Grey100,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ))
              else
                WidgetsModels.Container_widget(
                    null,
                    50,
                    Alignment.center,
                    const EdgeInsets.symmetric(horizontal: 30 , vertical: 20),
                    BoxDecoration(
                      color: ColorPalette.SH_Grey300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Text(
                      'Reset Password',
                      style: GoogleFonts.montserrat(
                          color: ColorPalette.SH_Grey100,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    )),
            ]),
          ),
        ),
      ),
    );
  }
}
