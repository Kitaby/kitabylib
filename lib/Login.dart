import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/validator.dart';
import 'package:kitabylib/Forgotyourpassword/forgotyourpassword.dart';
import 'package:kitabylib/models/api_services.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'Constants/widgets.dart';
import 'Constants/Colors.dart';
import 'Constants/Path.dart';
import 'models/login_request_model.dart';

class Login extends StatefulWidget {
  final String forgotmail;
  const Login({super.key, required this.forgotmail});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool state = false;
  static bool state2 = false;
  static bool hidetext = true;

  static GlobalKey<FormState> login = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.forgotmail;
    _emailController.addListener(() {
      final isEmailValid = validator.email(_emailController.value.text);
      if (isEmailValid != state) {
        setState(() {
          state = isEmailValid;
        });
      }
    });

    _passwordController.addListener(() {
      final ispasswordValid =
          validator.password(_passwordController.value.text);
      if (ispasswordValid != state2) {
        setState(() {
          state2 = ispasswordValid;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentwidth = MediaQuery.of(context).size.width ;
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
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              WidgetsModels.Container_widget(
                null,
                null,
                Alignment.center,
                const EdgeInsets.only(bottom: 20 , top: 20),
                null,
                Image.asset(Path.Logolib)
              ),
              WidgetsModels.Container_widget(
                null,
                40,
                Alignment.center,
                null,
                null,
                Text(
                  'Welcome Back',
                  style: GoogleFonts.montserrat(color: ColorPalette.backgroundcolor, fontSize: 30, fontWeight: FontWeight.w600),
                )
              ),
              WidgetsModels.Container_widget(
                null,
                25,
                Alignment.center,
                null,
                null,
                Text(
                  'Login to continue',
                  style: GoogleFonts.montserrat(color: ColorPalette.backgroundcolor, fontSize: 20, fontWeight: FontWeight.w300),
                )
              ),
              Form(
                key: login,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetsModels.customTTF_title(
                        'Email Adress',
                        null,
                        _emailController,
                        TextInputType.emailAddress,
                        Fieldvalidator.validateemail,
                        Icon(
                          FluentIcons.mail_24_regular,
                          color: ColorPalette.backgroundcolor,
                          size: 20,
                        ),
                        null,
                        false,
                        null
                      ),
                      WidgetsModels.customTTF_title(
                        'Password',
                        null,
                        _passwordController,
                        TextInputType.visiblePassword,
                        Fieldvalidator.validatepassword,
                        Icon(
                          FluentIcons.key_24_regular,
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
                              color: ColorPalette.SH_Grey900,
                            )
                          : Icon(
                              FluentIcons.eye_24_filled,
                              color: ColorPalette.SH_Grey900,
                            ),
                        ),
                        hidetext,
                        null
                      ),
                      WidgetsModels.Container_widget(
                        null,
                        null,
                        Alignment.centerRight,
                        null,
                        null,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Forgotyourpassword(
                                  oldmail: validator.email(
                                    _emailController.value.text
                                  )
                                  ? _emailController.value.text
                                  : ''
                                ),
                              )
                            ); //if the email is valid it will be transmitted to forgotyourpassword page
                          },
                          child: Text(
                            'Forgot your password?',
                            style: GoogleFonts.montserrat(
                              color: ColorPalette.backgroundcolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          ),
                        )
                      ),
                      if (validator.email(_emailController.value.text) && validator.password(_passwordController.value.text))
                      GestureDetector(
                        onTap: () async {
                          LoginRequestModel login = LoginRequestModel(
                            email: _emailController.value.text,
                            password: _passwordController.value.text
                          );
                          var response = await APISERVICES()
                          .login(login)
                          .catchError((error) {});
                          if (response != null) {
                            var message = jsonDecode(response);
                            if (message["message"] == "incorrect") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                WidgetsModels.Dialog_Message(
                                  "fail",
                                  "Credential false",
                                  "Please verify your email so you can us the app !"));
                                } 
                            else if (message["message"] == "not verified") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                WidgetsModels.Dialog_Message(
                                  "help",
                                  "Verify email",
                                  "Please verify your email so you can us the app !"));
                                } else {
                                  //var thisuser = userModelFromJson(response);
                                  //final SharedPreferences prefs =
                                  //await SharedPreferences.getInstance();
                                  //prefs.setString('token', thisuser.token);
                                  // ignore: use_build_context_synchronously
                                  Timer(const Duration(seconds: 6), () {
                                    Navigator.pushReplacementNamed(context, 'Home');
                                  });
                                }
                          }
                        },
                        child: WidgetsModels.Container_widget(
                          null,
                          50,
                          Alignment.center,
                          const EdgeInsets.all(30),
                          BoxDecoration(
                            color: ColorPalette.backgroundcolor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          Text(
                            'Log in',
                            style: GoogleFonts.montserrat(
                              color: ColorPalette.SH_Grey100,
                              fontSize: 22,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        )
                      )
                      else
                      WidgetsModels.Container_widget(
                        null,
                        50,
                        Alignment.center,
                        const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        BoxDecoration(
                          color: ColorPalette.SH_Grey300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        Text(
                          'Log in',
                          style: GoogleFonts.montserrat(
                            color: ColorPalette.SH_Grey100,
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          ),
                        )
                      ),
                      WidgetsModels.Container_widget(
                  null,
                  null,
                  Alignment.center,
                  const EdgeInsets.symmetric(horizontal: 25),
                  null,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont Have an account ? ',
                        style: GoogleFonts.montserrat(
                            color: ColorPalette.backgroundcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "SignUp1");
                        },
                        child: Text(
                          'SignUp',
                          style: GoogleFonts.montserrat(
                              color: Colors.lightBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}