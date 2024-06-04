import 'dart:async';
import 'package:kitabylib/Forgotyourpassword/forgotyourpassword2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordAnime extends StatefulWidget {
  const ForgotPasswordAnime({super.key, required this.email});
  final String email;
  @override
  State<ForgotPasswordAnime> createState() => _ForgotPasswordAnimeState();
}

class _ForgotPasswordAnimeState extends State<ForgotPasswordAnime> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 7, milliseconds: 500, microseconds: 200),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Forgotyourpassword2(
                      email: widget.email,
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image:  AssetImage("assets/images/Shape.png"), fit: BoxFit.cover)
        ),
        child: Container(
          height: 665,
          width: 456,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorPalette.SH_Grey100
          ),
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
                        color: ColorPalette.SH_Grey900),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "You can Reset your Password with the code",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.SH_Grey900),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
