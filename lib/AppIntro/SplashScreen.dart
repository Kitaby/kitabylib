import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kitabylib/Login.dart';
import 'package:kitabylib/Mainscreen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Colors.dart';
import '../Constants/Strings.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/Path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  @override
  void initState() {
    getToken();
    super.initState();
    Timer(
        const Duration(seconds: 3, milliseconds: 215, microseconds: 5),
        () => (token == null)
            ? Navigator.pushReplacementNamed(context, 'Intro1')
            : (token == "")
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login ()))
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Mainscreen(token: "",))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                Path.LogoAnime, // Replace with the path to your Lottie JSON file
                fit: BoxFit.cover,
                width: 400, // Adjust the width and height as needed
                height: 400,
              ),
            ),
            Center(
              child: AnimatedTextKit(animatedTexts: [
                TyperAnimatedText(
                  TextString.title,
                  textStyle: GoogleFonts.montserrat(
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.SH_Grey100),
                  speed: const Duration(milliseconds: 210),
                  curve: Curves.easeIn,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
