import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Strings.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:kitabylib/Login.dart';
import 'package:kitabylib/Mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
 

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
            color: Colors.white,
            ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(Path.Logolib),
            SvgPicture.asset(Path.Intro1 ,width: 300,),
            WidgetsModels.Container_widget(
                282,
                70,
                Alignment.center,
                null,
                null,
                Text(
                  "Control your library via a dashboard",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: ColorPalette.SH_Grey900,
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Image.asset(Path.Selected1,width: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Login(forgotmail: ''),));
                  },
                  child: WidgetsModels.Container_widget(
                    50,
                    21,
                    Alignment.center,
                    const EdgeInsets.only(left: 48),
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    Text(
                      TextString.skip,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: ColorPalette.SH_Grey900,
                        fontSize: 17,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'Intro2');
                  },
                  child: WidgetsModels.Container_widget(
                      100,
                      37,
                      Alignment.center,
                      const EdgeInsets.only(right: 48),
                      BoxDecoration(
                          color: ColorPalette.Primary_Color_Dark,
                          borderRadius: BorderRadius.circular(30)),
                      Text(
                        TextString.next,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: ColorPalette.SH_Grey100,
                          fontSize: 17,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ),
              ]
             )
              ]
          )
         )
        )
    ) 
    );
       }
     }