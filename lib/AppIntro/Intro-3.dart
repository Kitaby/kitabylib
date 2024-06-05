
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:kitabylib/Login.dart';

class Intro3 extends StatefulWidget {
  const Intro3({super.key});

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
 

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(Path.Logolib),
            SvgPicture.asset(Path.Intro3 ,width: 250,),
            WidgetsModels.Container_widget(
                282,
                70,
                Alignment.center,
                null,
                null,
                Text(
                  "Secure your files and keep history of it",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: ColorPalette.SH_Grey900,
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Image.asset(Path.Selected3,width: 150,),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Login(),));
              },
              child: WidgetsModels.Container_widget(
                      300,
                      50,
                      Alignment.center,
                      null,
                      BoxDecoration(
                          color: ColorPalette.Primary_Color_Dark,
                          borderRadius: BorderRadius.circular(5)),
                      Text(
                        "Get Started",
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
         )
        )
    ) 
    );
       }
     }