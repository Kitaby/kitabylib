import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Strings.dart';
import 'package:kitabylib/Constants/validator.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:kitabylib/Login.dart';
import 'package:kitabylib/models/forgot_password_request_model.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:kitabylib/Animations/ForgotPassword.dart';
import '../models/api_services.dart';
import '../models/auth/login_request_model.dart';
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
  static bool isStreched = true;

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
                          builder: (context) => Login(),
                        ));
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                    color: ColorPalette.backgroundcolor,
                  )),
            ),
            WidgetsModels.Container_widget(null, null, Alignment.center,
                const EdgeInsets.only(bottom: 30 , top: 50), null, Image.asset(Path.Logolib)),
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
              StatefulBuilder(
            builder: (contextbtn, setStatebtn) => GestureDetector(
                onTap: () async {
                  setStatebtn(() {
                    isStreched = false;
                  });
                  ForgotPasswordRequestModel ForgotPassword =
                      ForgotPasswordRequestModel(
                    email: _forgotemailController.value.text,
                  );
                  await Future.delayed(const Duration(seconds: 1));
                  await APISERVICES()
                      .forgetPassword(ForgotPassword)
                      .then((response) => {
                            setStatebtn(() {
                              isStreched = true;
                            }),
                            if (response.message == "success")
                              {
                                Navigator.pop(context),
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPasswordAnime(email: _forgotemailController.value.text),)),
                              }
                            else if (response.message == "user not found")
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    WidgetsModels.Dialog_Message(
                                        "fail",
                                        response.message!,
                                        "Please enter a valid email ")),
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    WidgetsModels.Dialog_Message("fail",
                                        "Unkwon error", "Please retry later")),
                              }
                          });
                },
                child: isStreched
                    ? WidgetsModels.Container_widget(
                        null,
                        50,
                        Alignment.center,
                        const EdgeInsets.all(25),
                        BoxDecoration(
                          color: ColorPalette.backgroundcolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        Text(
                          TextString.sendrequest,
                          style: GoogleFonts.montserrat(
                              color: ColorPalette.SH_Grey100,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    : WidgetsModels.buildSmallButton()),
          )
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
