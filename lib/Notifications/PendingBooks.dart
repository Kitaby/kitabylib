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
import 'package:kitabylib/models/Get-onHold-Books-Response-model.dart';
import 'package:kitabylib/models/api_services.dart';
import 'package:kitabylib/models/get-requested-books-response-model.dart';

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
    if(mounted){
    setState(() {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      _mediaQueryWidth = mediaQueryData.size.width*5/6;
      _mediaQueryHeight= mediaQueryData.size.height;
    });
  }}

   List<OnHoldBook> booksfound=[];
  
  bool hasmore =true;
  int page =1;
  bool isloading=false;
  final _list_offers_controller=ScrollController(); 

  Future fetchoffers(String name) async{
    if(isloading)return;
    isloading=true;
    GetOnHoldBooksResponseModel? response= await APISERVICES().getOnholdBooks('6638e4d14bca83d6fe6dfb40', page,name);///get loan books
    if(response!=null ){
      if(mounted){
        setState(() {
          page++;
          isloading=false;
          if( response.onHoldBooks.length<8){hasmore=false;}
          booksfound.addAll(response.onHoldBooks);
            });
          }
          }
            }

  Future refresh()async{
    if(mounted){
    setState(() {
      seeall=false;
      isloading=false;
      hasmore=true;
      page=1;
      booksfound.clear();
      _searchcontroller.text="";
        });
    fetchoffers("");
  }}
  
  @override
  void initState() {
    super.initState();
    fetchoffers("");
   
    
    
    _list_offers_controller.addListener(() {
      if(_list_offers_controller.position.maxScrollExtent==_list_offers_controller.offset){
        print(page);
        fetchoffers(_searchcontroller.text);
        
      }
    });


    

    
  }

  @override
  void dispose() {
    super.dispose();
    _list_offers_controller.dispose();
  }





  
  
 

 
void search(String e){
 if(mounted){
     setState(() {
       isloading=false;
      hasmore=true;
      page=1;
      booksfound.clear();
      seeall=false;
      fetchoffers(e);
    
     
     });
 }
  
   
}
 
  FocusNode focus =FocusNode();
  final _searchcontroller = TextEditingController();
  bool searchfocus =false; 
  bool seeall =false; 




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.verylightgrey,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(height: _mediaQueryWidth/11,color: Colors.white,
          child:Padding(
            padding: EdgeInsets.all(_mediaQueryWidth/50),
            child: WidgetsModels.searchbar(_searchcontroller,275,"Search",
                          
                            //prefix
                            GestureDetector(//set shared preferences
                              onTap: (){
                                  search(_searchcontroller.value.text);
                                         },
                              child: Icon(FluentIcons.search_20_regular,color: ColorPalette.SH_Grey900,)),
                            //suffix
                            null,
                                                      
                            //on submitted        
                            (p0) => search(p0),
                            
                            
                                                     
                            
                      ),
                      )
                     ),

              Container(
                height: _mediaQueryWidth/11,
                child: Padding(
                  padding: EdgeInsets.all(_mediaQueryWidth/40),
                  child: Text(
                        'Pending Books',
                        style: GoogleFonts.montserrat(
                          color: ColorPalette.SH_Grey900,
                          fontSize: _mediaQueryWidth/40,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                     
                ),
              ),
         
           StatefulBuilder(
                  
                    builder: (context,setStatelist) {
                      return RefreshIndicator(
                        onRefresh: refresh,
                        child: Container(
                              width: _mediaQueryWidth,
                              height:(_mediaQueryHeight-_mediaQueryWidth*(2/11)),//calculated
                              child: ListView.builder(
                                shrinkWrap: true,
                                
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: _list_offers_controller,
                                scrollDirection: Axis.vertical,
                                itemCount:booksfound.length+1,
                                itemBuilder: (context, i) {
                                  
                                       if(i<booksfound.length){

                                       return Column(
                                          children: [
                                            Container(
                                              height: _mediaQueryWidth*(1/4),
                                              margin:const EdgeInsets.only(left: 45 ),
                                              child:Row(
                                                children: [
                                                  WidgetsModels.bookcard(booksfound[i].bookName,_mediaQueryWidth/65,booksfound[i].author,_mediaQueryWidth/80,ColorPalette.SH_Grey900, booksfound[i].bookImage,_mediaQueryWidth/10,_mediaQueryWidth*(1/4),_mediaQueryWidth/10,_mediaQueryWidth*(1/8),false,null ),                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        WidgetsModels.Container_widget(_mediaQueryWidth/2, _mediaQueryWidth*(1/20), Alignment.center,const EdgeInsets.only(bottom: 10 ), null,  Text(booksfound[i].reserverName, style: GoogleFonts.montserrat(color: ColorPalette.SH_Grey900 , fontSize: 25 , fontWeight: FontWeight.w600),),),
                                                        WidgetsModels.Container_widget(_mediaQueryWidth/1.6,_mediaQueryWidth*(1/20), Alignment.topLeft,null, null, Text("PeriodType: Taking the book" , style: GoogleFonts.montserrat(color: ColorPalette.SH_Grey900 , fontSize: 18 , fontWeight: FontWeight.w400),), ),
                                                        WidgetsModels.Container_widget(_mediaQueryWidth/1.6,_mediaQueryWidth*(1/20), Alignment.topLeft, null,null,
                                                          countDown(
                                                            fontWeight: FontWeight.w400,
                                                            color: ColorPalette.SH_Grey900,
                                                            deadline: booksfound[i].date.add(
                                                               Duration(days: 3)
                                                            ),
                                                            fontSize: 17,
                                                          )
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 20),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () async{
                                                                      await APISERVICES().cancelreservation(booksfound[i].id);
                                                                       refresh();
                                                                    },
                                                                child: WidgetsModels.button1(_mediaQueryWidth/8, 35, ColorPalette.Error, FluentIcons.calendar_cancel_16_filled, ColorPalette.SH_Grey100, "Cancel Loan")),
                                                              SizedBox(width: 30,),
                                                              GestureDetector(
                                                                onTap: () async{
                                                                      await APISERVICES().givebook(booksfound[i].id);
                                                                       refresh();
                                                                    },
                                                                child: WidgetsModels.button1(_mediaQueryWidth/8, 35, ColorPalette.Secondary_Color_Orignal, FluentIcons.people_swap_16_filled, ColorPalette.SH_Grey100, "Give Book")),
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
  
                                       }
                                           else{
                                          return Padding(
                                              padding: EdgeInsets.symmetric(vertical: 32),
                                              child: Center(child:hasmore
                                              ?const CircularProgressIndicator()
                                              : Text(
                                                  'No More Books',
                                                    style: GoogleFonts.montserrat(
                                                      color: ColorPalette.SH_Grey100,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500),
                                                      )),
                                              );
                  
                                        }
                                     },),),
                      );
                    }
                  )
                   

        ],
      ),

    );
    }
}