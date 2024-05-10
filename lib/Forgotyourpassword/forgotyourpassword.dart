import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/validator.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:kitabylib/login.dart';
import 'package:kitabylib/models/forgot_password_request_model.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:kitabylib/Animations/ForgotPassword.dart';
import '../models/api_services.dart';
import '../models/login_request_model.dart';
import 'forgotyourpassword2.dart';

class Forgotyourpassword extends StatefulWidget {
  final String oldmail;
  const Forgotyourpassword({super.key, required this.oldmail});
  @override
  State<Forgotyourpassword> createState() => Forgotyourpasswordstate();
}

class Forgotyourpasswordstate extends State<Forgotyourpassword> {
  final _forgotemailController = TextEditingController();
  static GlobalKey<FormState> forgotyourpassword = GlobalKey();
  static bool state = false;

  @override
  void initState() {
    super.initState();
    _forgotemailController.text = widget.oldmail;
    _forgotemailController.addListener(() {
      final isEmailValid = validator.email(_forgotemailController.value.text);
      if (isEmailValid != state) {
        setState(() {
          state = isEmailValid;
        });
      }
      ;
    });
  }

  @override
  void dispose() {
    _forgotemailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image : DecorationImage(image: AssetImage("assets/images/Shape.png"), fit: BoxFit.cover),
        ),
        child: Container(
          height: 650,
          width: 456,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          color: ColorPalette.SH_Grey100,
          ),
          child: ListView(physics: const NeverScrollableScrollPhysics(), children: [
            WidgetsModels.Container_widget(
              null,
              null,
              Alignment.topLeft,
              const EdgeInsets.only(left: 15 , top: 15),
              null,
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(
                              forgotmail:
                                  validator.email(_forgotemailController.value.text)
                                      ? _forgotemailController.value.text
                                      : ''),
                        ));
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                    color: ColorPalette.backgroundcolor,
                  )),
            ),
            WidgetsModels.Container_widget(null, null, Alignment.center,
                const EdgeInsets.only(bottom: 30 , top: 50), null, Image.asset(Path.LogoImg)),
            WidgetsModels.Container_widget(
                null,
                40,
                Alignment.center,
                const EdgeInsets.only(bottom: 10),
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
                25,
                Alignment.center,
                null,
                null,
                Text(
                  'We’ll email you a link to reset your password',
                  style: GoogleFonts.montserrat(
                      color: ColorPalette.backgroundcolor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )),
            Form(
                key: forgotyourpassword,
                child: Container(
                  height: 130,
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: WidgetsModels.customTTF_title(
                      'Email Adress',
                      null,
                      _forgotemailController,
                      TextInputType.emailAddress,
                      Fieldvalidator.validateemail,
                      Icon(
                        Icons.mail_outline_outlined,
                        color: ColorPalette.backgroundcolor,
                        size: 20,
                      ),
                      null,
                      false,
                      null),
                )),
            if (validator.email(_forgotemailController.value.text))
              GestureDetector(
                  onTap: () async {
                    ForgotPasswordRequestModel ForgotPassword =
                        ForgotPasswordRequestModel(
                      email: _forgotemailController.value.text,
                    );
                    var response = await APISERVICES()
                        .forgetPassword(ForgotPassword)
                        .catchError((error) {
                      print(error);
                    });
                    if (response != null) {
                      var responsedecoded = jsonDecode(response);
                      var data = responsedecoded["message"];
                      if (data == "success") {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordAnime(
                                email: validator
                                        .email(_forgotemailController.value.text)
                                    ? _forgotemailController.value.text
                                    : '',
                              ),
                            ));
                      }
                    }
                  },
                  child: WidgetsModels.Container_widget(
                    null,
                    50,
                    Alignment.center,
                    const EdgeInsets.symmetric(horizontal: 55 , vertical: 25),
                    BoxDecoration(
                      color: ColorPalette.backgroundcolor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Text(
                      'Send Request',
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
                  const EdgeInsets.symmetric(
                    horizontal: 55,
                    vertical: 25,
                  ),
                  BoxDecoration(
                    color: ColorPalette.SH_Grey300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  Text(
                    'Send Request',
                    style: GoogleFonts.montserrat(
                        color: ColorPalette.SH_Grey100,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  )),
          ]),
        ),
      ),
    );
  }
}
