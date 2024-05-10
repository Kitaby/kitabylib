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

import '../models/api_services.dart';
import '../models/register_request_model.dart';

class Signup3 extends StatefulWidget {
  Signup3({
    super.key,
    required this.phone,
    required this.email,
    required this.password,
    required this.name,
  });
  final String phone;
  final String email;
  final String password;
  final String name;

  @override
  State<Signup3> createState() => _Signup3State();
}

class _Signup3State extends State<Signup3> {
  List<String> categories = [];
  bool cardclick1 = false;
  bool cardclick2 = false;
  bool cardclick3 = false;
  bool cardclick4 = false;
  bool cardclick5 = false;
  bool cardclick6 = false;

  static String data = "";
  static bool state4 = false;
  static bool state5 = false;
  static bool state6 = false;
  static GlobalKey<FormState> Signup = GlobalKey();

  final _libNameController = TextEditingController();
  final _commercialRegisterNumberController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _libNameController.addListener(() {
      final isnameValid = validator.name(_libNameController.value.text);
      if (isnameValid != state4) {
        setState(() {
          state4 = isnameValid;
        });
      }
    });

    _commercialRegisterNumberController.addListener(() {
      final isPhonenumberValid =
          validator.phone(_commercialRegisterNumberController.value.text);
      if (isPhonenumberValid != state5) {
        setState(() {
          state5 = isPhonenumberValid;
        });
      }
    });

    _addressController.addListener(() {
      final isPinValid = Fieldvalidator.isPin(_addressController.value.text);
      if (isPinValid != state6) {
        setState(() {
          state6 = isPinValid;
        });
      }
    });
  }

  @override
  void dispose() {
    _libNameController.dispose();
    _commercialRegisterNumberController.dispose();
    _addressController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 25 , vertical: 10),
          child: ListView(
            //physics: const NeverScrollableScrollPhysics(),
            children: [
              WidgetsModels.Container_widget(
                  null,
                  null,
                  Alignment.center,
                  const EdgeInsets.only(bottom: 15),
                  null,
                  Image.asset(Path.LogoImg)),
              WidgetsModels.Container_widget(
                  null,
                  40,
                  Alignment.center,
                  null,
                  null,
                  Text(
                    'Welcome Here',
                    style: GoogleFonts.montserrat(
                        color: ColorPalette.backgroundcolor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  )),
              WidgetsModels.Container_widget(
                null,
                25,
                Alignment.center,
                EdgeInsets.only(bottom: 15),
                null,
                Text(
                  'Sign to continue',
                  style: GoogleFonts.montserrat(
                    color: ColorPalette.backgroundcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                )),
              WidgetsModels.Container_widget(
                  null,
                  35,
                  Alignment.center,
                  null,
                  null,
                  Image.asset(Path.Selected3)
              ),
              Form(
                key: Signup,
                child: Column(
                  children: [
                    WidgetsModels.customTTF_title(
                      "Library Name",
                      null,
                      _libNameController,
                      TextInputType.name,
                      Fieldvalidator.validateLibname,
                      Icon(
                        FluentIcons.mail_24_regular,
                        color: ColorPalette.backgroundcolor,
                      ),
                      null,
                      false,
                      null
                    ),
                    WidgetsModels.customTTF_title(
                      "Commercial Register Number",
                      null,
                      _commercialRegisterNumberController,
                      TextInputType.number,
                      Fieldvalidator.validateLibname,
                      Icon(
                        FluentIcons.barcode_scanner_24_regular,
                        color: ColorPalette.backgroundcolor,
                      ),
                      null,
                      false,
                      10
                    ),
                    WidgetsModels.customTTF_title(
                      "Address",
                      null,
                      _addressController,
                      TextInputType.number,
                      Fieldvalidator.validateLibname,
                      Icon(
                        FluentIcons.location_24_regular,
                        color: ColorPalette.backgroundcolor,
                      ),
                      null,
                      false,
                      10
                    ),
                  ],
                )
              ),
              if ((validator.name(_libNameController.value.text)) &&
                      (validator.phone(_commercialRegisterNumberController.value.text)) &&
                      (Fieldvalidator.isPin(_addressController.value.text)))
                    GestureDetector(
                        onTap: () async {
                          PhoneVerifyOtpRequestModel phoneVerifyOTP =
                              PhoneVerifyOtpRequestModel(
                                  phone: _commercialRegisterNumberController.value.text,
                                  otp: _addressController.value.text,
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
                                                .name(_libNameController.value.text)
                                            ? _libNameController.value.text
                                            : '',
                                        phone: validator.phone(
                                                _commercialRegisterNumberController.value.text)
                                            ? _commercialRegisterNumberController.value.text
                                            : ''),
                                  ));
                            }
                          }
                        },
                        child: WidgetsModels.Container_widget(
                            50,
                            40,
                            Alignment.center,
                            const EdgeInsets.only(bottom: 20 , top: 15 , left: 30 , right: 30),
                            BoxDecoration(
                                color: ColorPalette.backgroundcolor,
                                borderRadius: BorderRadius.circular(5)),
                            Text("Register",
                                style: GoogleFonts.montserrat(
                                    color: ColorPalette.SH_Grey100,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600))))
                  else
                    WidgetsModels.Container_widget(
                        50,
                        40,
                        Alignment.center,
                        const EdgeInsets.only(bottom: 20 , top: 15 , left: 30 , right: 30),
                        BoxDecoration(
                            color: ColorPalette.SH_Grey300,
                            borderRadius: BorderRadius.circular(5)),
                        Text("Register",
                            style: GoogleFonts.montserrat(
                                color: ColorPalette.SH_Grey100,
                                fontSize: 22,
                                fontWeight: FontWeight.w600))),
            ],
          ),
        ),
      ),
    );
  }
}
