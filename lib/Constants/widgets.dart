import 'dart:ffi';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Path.dart';

class WidgetsModels {
  static Container Container_widget(
    double? varwidth,
    double? varheight,
    Alignment? varalignment,
    EdgeInsets? varmargin,
    BoxDecoration? vardecoration,
    Widget? w,
  ) {
    return Container(
      width: varwidth,
      height: varheight,
      alignment: varalignment, //A conatiner that have a widget child
      margin: varmargin,
      decoration: vardecoration,
      child: w,
    );
  }
  static TextStyle customtextstyle(Color varcolor, double varsize,
      FontWeight varfontweight, String varfontfamily) {
    return TextStyle(
      color: varcolor,
      fontSize: varsize, //textstyle of a textwidget
      fontWeight: varfontweight,
      fontFamily: varfontfamily,
    );
  }

  static TextFormField customTFF(
      TextEditingController varcontroller,
      TextStyle varstyle,
      AutovalidateMode varavm,
      TextInputType varkt,
      var vali,
      InputDecoration vardecoration,
      bool varobscure,
      int? varlength) {
    return TextFormField(
      controller: varcontroller,
      style: varstyle,
      autovalidateMode: varavm, //TextFormField
      keyboardType: varkt,
      validator: vali,
      decoration: vardecoration,
      cursorColor: ColorPalette.backgroundcolor,
      obscureText: varobscure,
      maxLength: varlength,
    );
  }

  static TextField customTF(
      TextEditingController varcontroller,
      TextStyle varstyle,
      TextInputType varkt,
      InputDecoration vardecoration,
      bool varobscure,
      int? varlength,
      int? vatlines) {
    return TextField(
      controller: varcontroller,
      style: varstyle,
      keyboardType: varkt,
      decoration: vardecoration,
      cursorColor: ColorPalette.SH_Grey100,
      obscureText: varobscure,
      maxLength: varlength,
      maxLines: vatlines,
    );
  }

  static InputDecoration customdecoration1(
      Widget varprefix, Widget? varsuffix) {
    return InputDecoration(
      counterText: '',
      errorStyle: GoogleFonts.montserrat(
          fontSize: 14, color: ColorPalette.Error, fontWeight: FontWeight.w500),
      prefixIcon: Align(
        heightFactor: 1.0,
        widthFactor: 1.0,
        child: varprefix,
      ),
      suffixIcon: Align(
        heightFactor: 1.0,
        widthFactor: 2.0,
        child: varsuffix,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.backgroundcolor, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.Error, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.Error, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.backgroundcolor, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.backgroundcolor, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      //Decoration of textformfieldborders
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.backgroundcolor, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static SnackBar Dialog_Message(String type, String info1, String info2) {
    return SnackBar(
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 100,
            decoration: BoxDecoration(
              color: (type == "success")
                  ? ColorPalette.Secondary_Color_Dark
                  : (type == "fail")
                      ? ColorPalette.snackErroColor
                      : (type == "warning")
                          ? ColorPalette.snackWarning
                          : ColorPalette.Primary_Color_Light,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info1,
                        style: GoogleFonts.montserrat(
                            color: ColorPalette.SH_Grey100,
                            fontWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
                      const Spacer(),
                      Text(
                        info2,
                        style: GoogleFonts.montserrat(
                            color: ColorPalette.SH_Grey100,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(20)),
                  child: SvgPicture.asset(
                    Path.pathBubble,
                    height: 65,
                    width: 60,
                    color: (type == "success")
                        ? ColorPalette.snackBubblesucces
                        : (type == "fail")
                            ? ColorPalette.snackBubbleerror
                            : (type == "warning")
                                ? ColorPalette.snackBubbleWarning
                                : ColorPalette.Primary_Color_Dark,
                  ))),
          if (type == "success")
            Positioned(
              top: -30,
              left: 10,
              child: SvgPicture.asset(
                Path.pathsucces,
                height: 60,
              ),
            ),
          if (type == "fail")
            Positioned(
              top: -30,
              left: 10,
              child: SvgPicture.asset(
                Path.pathfail,
                height: 60,
              ),
            ),
          if (type == "help")
            Positioned(
              top: -30,
              left: 10,
              child: SvgPicture.asset(
                Path.pathquestion,
                height: 60,
              ),
            ),
          if (type == "warning")
            Positioned(
              top: -30,
              left: 10,
              child: SvgPicture.asset(
                Path.pathwarning,
                height: 60,
              ),
            ),
        ],
      ),
    );
  }

  static Container customTTF_title(
    String vartitle,
    EdgeInsets? varmargin,
    TextEditingController varcontroller,
    TextInputType varkeybordtype,
    var vali, //
    Widget varprefix,
    Widget? varsuffix,
    bool varobscure,
    int? varlength,
  ) {
    return Container(
      height: 111,
      margin: varmargin,
      child: Column(
        children: [
          Container_widget(
              null,
              null,
              Alignment.centerLeft,
              const EdgeInsets.all(10),
              null,
              Text(vartitle,
                  style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.backgroundcolor))),
          Container_widget(
              null,
              null,
              null,
              null,
              null,
              customTFF(
                  varcontroller,
                  GoogleFonts.montserrat(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.backgroundcolor),
                  AutovalidateMode.onUserInteraction,
                  varkeybordtype,
                  vali,
                  customdecoration1(
                    varprefix,
                    varsuffix,
                  ),
                  varobscure,
                  varlength))
        ],
      ),
    );
  }

  static Container customcard1(
    String vartitle,
    bool varbool,
    var varontap,
  ) {
    return Container(
      width: 80,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
                color: (varbool)
                    ? ColorPalette.Secondary_Color_Orignal
                    : Colors.transparent)),
        child: ListTile(
          onTap: varontap,
          visualDensity: const VisualDensity(vertical: -3),
          title: Text(
            vartitle , 
            style: GoogleFonts.montserrat(
              color: ColorPalette.SH_Grey100,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          tileColor: ColorPalette.Primary_Color_Dark,
        ),
      ),
    );
  }

  static Container bookcard(
      String vartitle,
      double titlefontsize,
      String varauthor,
      double authorfontsize,
      Color varcolor,
      String varimage,
      double containerwidth,
      double? containerheight,
      double imagewidth,
      double imageheight,
      bool selected,
      String? booktype) {
    return Container(
      width: containerwidth,
      height: containerheight,
      child: Column(children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: (selected)
                      ? Border.all(
                          width: 3, color: ColorPalette.Secondary_Color_Orignal)
                      : null,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/Logo.png', // Before image load
                  image: varimage, // After image load
                  width: imagewidth,
                  height: imageheight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (booktype == 'loan')
              Positioned(
                  top: 0,
                  right: imagewidth / 7,
                  child: WidgetsModels.Container_widget(
                    imagewidth / 7,
                    imagewidth / 7,
                    Alignment.center,
                    null,
                    BoxDecoration(
                        color: ColorPalette.Secondary_Color_Orignal,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    Icon(
                      FluentIcons.book_clock_20_filled,
                      size: imagewidth / 8,
                      color: ColorPalette.SH_Grey100,
                    ),
                  )),
            if (booktype == 'wishlist')
              Positioned(
                  top: 0,
                  right: imagewidth / 7,
                  child: WidgetsModels.Container_widget(
                    imagewidth / 7,
                    imagewidth / 7,
                    Alignment.center,
                    null,
                    BoxDecoration(
                        color: ColorPalette.Secondary_Color_Orignal,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    Icon(
                      FluentIcons.bookmark_20_filled,
                      size: imagewidth / 8,
                      color: ColorPalette.SH_Grey100,
                    ),
                  )),
            if (booktype == 'mybooks')
              Positioned(
                  top: 0,
                  right: imagewidth / 7,
                  child: WidgetsModels.Container_widget(
                    imagewidth / 7,
                    imagewidth / 7,
                    Alignment.center,
                    null,
                    BoxDecoration(
                        color: ColorPalette.Secondary_Color_Orignal,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    Icon(
                      FluentIcons.book_20_filled,
                      size: imagewidth / 8,
                      color: ColorPalette.SH_Grey100,
                    ),
                  )),
          ],
        ),
        SizedBox(height: imagewidth / 30),
        WidgetsModels.Container_widget(
            null,
            null,
            Alignment.center,
            null,
            null,
            Text(
              vartitle,
              style: GoogleFonts.montserrat(
                  color: (selected)
                      ? ColorPalette.Secondary_Color_Orignal
                      : varcolor,
                  fontWeight: FontWeight.w500,
                  fontSize: titlefontsize),
              textAlign: TextAlign.center,
            )),
        SizedBox(height: imagewidth / 30),
        WidgetsModels.Container_widget(
            null,
            null,
            Alignment.center,
            null,
            null,
            Text(
              varauthor,
              style: GoogleFonts.montserrat(
                  color: (selected)
                      ? ColorPalette.Secondary_Color_Orignal
                      : varcolor,
                  fontWeight: FontWeight.w400,
                  fontSize: authorfontsize),
              textAlign: TextAlign.center,
            )),
      ]),
    );
  }

  

  static RatingBar rating(
      double size, double initRate, bool ignoreGest, double padding) {
    return RatingBar.builder(
        itemSize: size,
        allowHalfRating: true,
        minRating: 0,
        initialRating: initRate,
        ignoreGestures: ignoreGest,
        itemPadding: EdgeInsets.symmetric(horizontal: padding),
        itemBuilder: (context, index) {
          return Icon(FluentIcons.star_24_filled, color: ColorPalette.Star);
        },
        onRatingUpdate: (rating) {});
  }

  static Container button1(double varwidth, double varheight, Color varcolor,
      IconData varicon, Color variconcolor, String vartitle) {
    return Container(
      width: varwidth,
      height: varheight,
      decoration: BoxDecoration(
          color: varcolor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(
          varicon,
          size: varheight / 2,
          color: variconcolor,
        ),
        Text(
          vartitle,
          style: GoogleFonts.montserrat(
              color: variconcolor,
              fontWeight: FontWeight.w700,
              fontSize: varwidth / 10),
        )
      ]),
    );
  }

  static Container titlenr() {
    return WidgetsModels.Container_widget(
      null,
      100,
      Alignment.center,
      null,
      BoxDecoration(color: ColorPalette.Primary_Color_Original),
      Text(
        TextString.title,
        style: GoogleFonts.montserrat(
            color: ColorPalette.SH_Grey100,
            fontSize: 32,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  static Container title(BuildContext context) {
    return WidgetsModels.Container_widget(
        null,
        80,
        Alignment.center,
        null,
        BoxDecoration(color: ColorPalette.Primary_Color_Original),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 104),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                    color: ColorPalette.SH_Grey100,
                  )),
            ),
            Text(
              TextString.title,
              style: GoogleFonts.montserrat(
                  color: ColorPalette.SH_Grey100,
                  fontSize: 32,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ));
  }

  static Container searchbar(
      TextEditingController varcontroller,
      double? varwidth,
      String varhinttext,
      Widget? varprefix,
      Widget? varsuffix,
      Function(String) varonchanged,
      Function(String) varonsubmitted) {
    return Container(
      width: varwidth,
      child: TextField(
        onChanged: varonchanged,
        onSubmitted: varonsubmitted,
        controller: varcontroller,
        cursorColor: ColorPalette.SH_Grey900,
        decoration: InputDecoration(
          hintText: varhinttext,
          filled: true,
          fillColor: ColorPalette.SH_Grey100,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          prefixIcon: Align(
            heightFactor: 1.0,
            widthFactor: 1.0,
            child: varprefix,
          ),
          suffixIcon: Align(
            heightFactor: 1.0,
            widthFactor: 2.0,
            child: varsuffix,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
        ),
      ),
    );
  }

  
  
  

}
