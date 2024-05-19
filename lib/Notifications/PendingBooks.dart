import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/Path.dart';
import 'package:kitabylib/Constants/widgets.dart';
import 'package:kitabylib/CountDown.dart';

class PendingBooks extends StatefulWidget {
  const PendingBooks({super.key});

  @override
  State<PendingBooks> createState() => _PendingBooksState();
}

class _PendingBooksState extends State<PendingBooks> {
  double _mediaQueryWidth = 0.0;
  double _mediaQueryHeight = 0.0;

  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call updateMediaQuerySize in didChangeDependencies
    updateMediaQuerySize();
  }

  void updateMediaQuerySize() {
    setState(() {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      _mediaQueryWidth = mediaQueryData.size.width*5/6;
      _mediaQueryHeight= mediaQueryData.size.height;
    });
  }

  List notificationsLoan = [
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
    {'periodType' : "Taking the book"},
  ];

  Future<List> getData() async{
    var response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List responsebody = jsonDecode(response.body);
    return responsebody;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FA) ,
      body: ListView(
        children: [
          Padding(
            padding:EdgeInsets.all(_mediaQueryWidth/40),
            child: Text(
              'Loan Requests',
              style: GoogleFonts.montserrat(
                color: ColorPalette.SH_Grey900,
                fontSize: _mediaQueryWidth/40,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(
            height: _mediaQueryHeight,
            child: FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: Image.asset(Path.Logolib),);
                }
                return ListView.builder(
                  itemCount: notificationsLoan.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: _mediaQueryWidth*(1/4),
                          margin:const EdgeInsets.only(left: 45 ),
                          child:Row(
                            children: [
                              WidgetsModels.bookcard("The end ",_mediaQueryWidth/65,"Author",_mediaQueryWidth/80,ColorPalette.SH_Grey900,"https://edit.org/images/cat/book-covers-big-2019101610.jpg",_mediaQueryWidth/10,_mediaQueryWidth*(1/6),_mediaQueryWidth/10,_mediaQueryWidth*(1/8),false,null ),                                 
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidgetsModels.Container_widget(_mediaQueryWidth/2, _mediaQueryWidth*(1/20), Alignment.center,const EdgeInsets.only(bottom: 10 ), null,  Text("User's name " , style: GoogleFonts.montserrat(color: ColorPalette.SH_Grey900 , fontSize: 25 , fontWeight: FontWeight.w600),),),
                                    WidgetsModels.Container_widget(_mediaQueryWidth/1.6,_mediaQueryWidth*(1/20), Alignment.topLeft,null, null, Text("PeriodType: Taking the book" , style: GoogleFonts.montserrat(color: ColorPalette.SH_Grey900 , fontSize: 18 , fontWeight: FontWeight.w400),), ),
                                    WidgetsModels.Container_widget(_mediaQueryWidth/1.6,_mediaQueryWidth*(1/20), Alignment.topLeft, null,null,
                                      countDown(
                                        fontWeight: FontWeight.w400,
                                        color: ColorPalette.SH_Grey900,
                                        deadline: DateTime.now().add(
                                          const Duration(days: 10)
                                        ),
                                        fontSize: 17,
                                      )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          WidgetsModels.button1(_mediaQueryWidth/8, 35, ColorPalette.Error, FluentIcons.calendar_cancel_16_filled, ColorPalette.SH_Grey100, "Cancel Loan"),
                                          SizedBox(width: 30,),
                                          WidgetsModels.button1(_mediaQueryWidth/8, 35, ColorPalette.Secondary_Color_Orignal, FluentIcons.people_swap_16_filled, ColorPalette.SH_Grey100, "Confirming"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ), 
                        WidgetsModels.Container_widget(null, 1, null,const EdgeInsets.symmetric(vertical: 20), BoxDecoration(color: Color(0xffD8D8D8)), null),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}