import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kitabylib/Constants/validator.dart';
import 'package:kitabylib/SignUp/SignUp2.dart';
import 'package:kitabylib/models/phone_otp_request_model.dart';
import 'package:kitabylib/models/phone_verify_otp_request_model.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:kitabylib/login.dart';

import '../models/api_services.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});
  @override
  State<SignUp1> createState() => SignUp1state();
}

class SignUp1state extends State<SignUp1> {
  static String data = "";
  static bool state4 = false;
  static bool state5 = false;
  static bool state6 = false;
  static GlobalKey<FormState> Signup = GlobalKey();

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      final isnameValid = validator.name(_nameController.value.text);
      if (isnameValid != state4) {
        setState(() {
          state4 = isnameValid;
        });
      }
    });

    _phoneNumberController.addListener(() {
      final isPhonenumberValid =
          validator.phone(_phoneNumberController.value.text);
      if (isPhonenumberValid != state5) {
        setState(() {
          state5 = isPhonenumberValid;
        });
      }
    });

    _pinController.addListener(() {
      final isPinValid = Fieldvalidator.isPin(_pinController.value.text);
      if (isPinValid != state6) {
        setState(() {
          state6 = isPinValid;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _pinController.dispose();
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
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25 , vertical: 10),
              child: ListView(
                //physics:const NeverScrollableScrollPhysics(),
                //physics: const ClampingScrollPhysics(),
                children: [
                  Center(child: Image.asset(Path.LogoImg)),
                  WidgetsModels.Container_widget(
                      40,
                      33,
                      Alignment.center,
                      const EdgeInsets.only(top: 10),
                      null,
                      Text("Welcome Here",
                          style: GoogleFonts.montserrat(
                              color: ColorPalette.backgroundcolor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600))),
                  WidgetsModels.Container_widget(
                      20,
                      25,
                      Alignment.center,
                      const EdgeInsets.only(bottom: 15),
                      null,
                      Text("Sign to continue",
                          style: GoogleFonts.montserrat(
                              color: ColorPalette.backgroundcolor,
                              fontSize: 20,
                              fontWeight: FontWeight.w300))),
                  WidgetsModels.Container_widget(100, 35, Alignment.center, null,
                      null, Image.asset(Path.Selected1)),
                  Form(
                      key: Signup,
                      child: Column(
                        children: [
                          WidgetsModels.customTTF_title(
                              "Full Name",
                              null,
                              _nameController,
                              TextInputType.name,
                              Fieldvalidator.validatename,
                              Icon(
                                FluentIcons.person_24_regular,
                                color: ColorPalette.backgroundcolor,
                              ),
                              null,
                              false,
                              null),
                          WidgetsModels.customTTF_title(
                              "Phone Number",
                              null,
                              _phoneNumberController,
                              TextInputType.number,
                              Fieldvalidator.validatePhoneNumber,
                              Icon(
                                FluentIcons.call_24_regular,
                                color: ColorPalette.backgroundcolor,
                              ),
                              null,
                              false,
                              10),
                          WidgetsModels.customTTF_title(
                              "Code pin",
                              null,
                              _pinController,
                              TextInputType.number,
                              Fieldvalidator.validatePinCode,
                              Icon(
                                FluentIcons.lock_shield_24_regular,
                                color: ColorPalette.backgroundcolor,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  PhoneOtpRequestModel phoneOTP =
                                      PhoneOtpRequestModel(
                                    phone: _phoneNumberController.value.text,
                                  );
                                  var response = await APISERVICES()
                                      .sendotp(phoneOTP)
                                      .catchError((error) {
                                    print(error);
                                  });
                                  if (response != null) {
                                    var responsedecoded = jsonDecode(response);
                                    data = responsedecoded["data"];
                                  }
                                },
                                child: Text("Send",
                                    style: GoogleFonts.montserrat(
                                        color: ColorPalette.backgroundcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ),
                              false,
                              6),
                        ],
                      )),
                  if ((validator.name(_nameController.value.text)) &&
                      (validator.phone(_phoneNumberController.value.text)) &&
                      (Fieldvalidator.isPin(_pinController.value.text)))
                    GestureDetector(
                        onTap: () async {
                          PhoneVerifyOtpRequestModel phoneVerifyOTP =
                              PhoneVerifyOtpRequestModel(
                                  phone: _phoneNumberController.value.text,
                                  otp: _pinController.value.text,
                                  data: data);
                          var response = await APISERVICES()
                              .verifyotp(phoneVerifyOTP)
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
                                    builder: (context) => Signup2(
                                        name: validator
                                                .name(_nameController.value.text)
                                            ? _nameController.value.text
                                            : '',
                                        phone: validator.phone(
                                                _phoneNumberController.value.text)
                                            ? _phoneNumberController.value.text
                                            : ''),
                                  ));
                            }
                          }
                        },
                        child: WidgetsModels.Container_widget(
                            50,
                            40,
                            Alignment.center,
                            const EdgeInsets.only(bottom: 20 , top: 5 , left: 25 , right: 25),
                            BoxDecoration(
                                color: ColorPalette.backgroundcolor,
                                borderRadius: BorderRadius.circular(5)),
                            Text("Next",
                                style: GoogleFonts.montserrat(
                                    color: ColorPalette.SH_Grey100,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600))))
                  else
                    WidgetsModels.Container_widget(
                        50,
                        40,
                        Alignment.center,
                        const EdgeInsets.only(bottom: 20 , top: 5 , left: 30 , right: 30),
                        BoxDecoration(
                            color: ColorPalette.SH_Grey300,
                            borderRadius: BorderRadius.circular(5)),
                        Text("Next",
                            style: GoogleFonts.montserrat(
                                color: ColorPalette.SH_Grey100,
                                fontSize: 22,
                                fontWeight: FontWeight.w600))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: GoogleFonts.montserrat(
                            color: ColorPalette.backgroundcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(forgotmail: ''),
                              ));
                        },
                        child: Text(" Login",
                            style: GoogleFonts.montserrat(
                                color: Colors.lightBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
