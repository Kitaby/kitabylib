import 'dart:async';
import 'package:kitabylib/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerif extends StatefulWidget {
  const EmailVerif({super.key});

  @override
  State<EmailVerif> createState() => _EmailVerifState();
}

class _EmailVerifState extends State<EmailVerif> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 7, milliseconds: 500, microseconds: 200),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Login(
                      forgotmail: "",
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                Path.EmailAnime, // Replace with the path to your Lottie JSON file
                fit: BoxFit.cover,
                width: 200, // Adjust the width and height as needed
                height: 200,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Text(
                  "An Email is Sent",
                  style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.SH_Grey100),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "Please Verify your mailBox",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.SH_Grey100),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
