import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Constants/validator.dart';
import 'package:kitabylib/Constants/widgets.dart';

class Addbook extends StatefulWidget {
 
  const Addbook({super.key,});
@override
  State<Addbook> createState() => Addbookstate();
}



class Addbookstate extends State<Addbook> {


 double _mediaQueryWidth = 0.0;
 double _mediaQueryHeight = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call updateMediaQuerySize in didChangeDependencies
    updateMediaQuerySize();
  }

  void updateMediaQuerySize() {
    setState(() {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      _mediaQueryWidth = mediaQueryData.size.width*5/6;
      _mediaQueryHeight = mediaQueryData.size.height;
    });
  }


static bool state = false;

@override
  void initState() {
    super.initState();
    _isbncontroller.addListener(() {
      if(_isbncontroller.value.text.isNotEmpty&&Fieldvalidator.isisbnvalid(_isbncontroller.value.text)){
        setState(() {
          canadd=true;
        });
      }else{
        setState(() {
          canadd=false;
        });
      }
    });
  }


bool canadd=false;
 final TextEditingController _isbncontroller=TextEditingController();

@override
  Widget build(BuildContext context) {
    return Dialog(
     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
     child: SizedBox(
      height: _mediaQueryHeight/2,
      width: _mediaQueryWidth/2,

       child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           
           const Image(image: AssetImage("assets/images/Barcode-rafiki.png")),
     
           WidgetsModels.Container_widget(300,null,null,const EdgeInsets.only(bottom: 20),null,Text('Enter the code in the back of the book Or search it on google ! ',style: GoogleFonts.montserrat(color: ColorPalette.SH_Grey900,fontWeight:FontWeight.w600,fontSize: 16.5 ),textAlign: TextAlign.center,)),
           
           Column(
             children: [
               WidgetsModels.Container_widget(null,null,Alignment.centerLeft,const EdgeInsets.symmetric(horizontal: 30,vertical:5),null,Text('ISBN',style: GoogleFonts.montserrat(color: ColorPalette.SH_Grey900,fontWeight:FontWeight.w600,fontSize: 10 ),textAlign: TextAlign.center,)),
               Padding(
             padding: const EdgeInsets.symmetric(horizontal:20),
             child: TextFormField(
              controller:_isbncontroller ,
              keyboardType: TextInputType.number,
              cursorColor: ColorPalette.SH_Grey900,
              validator: Fieldvalidator.validateisbn,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 13,
              style: GoogleFonts.montserrat(fontSize:15,fontWeight: FontWeight.w500,color: ColorPalette.SH_Grey500 ),
              decoration: InputDecoration(
                  counterText: '',
                  errorStyle: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: ColorPalette.Error,
                      fontWeight: FontWeight.w500),
                  prefixIcon: Align(
                    heightFactor: 1.0,
                    widthFactor: 1.0,
                    child: Icon(
                      FluentIcons.barcode_scanner_24_filled,
                      color: ColorPalette.SH_Grey900,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.SH_Grey900, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.Error, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.Error, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.SH_Grey900, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.SH_Grey900, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.SH_Grey900, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            
             ],
           ),
           
            Padding(
             padding:const EdgeInsets.all(20),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: WidgetsModels.button1(130, 35, ColorPalette.Error, FluentIcons.calendar_cancel_16_filled, ColorPalette.SH_Grey100, "Cancel")),
                


                if(canadd==true)
                GestureDetector(
                  onTap:()async {
                    
                   //await APISERVICES().PostBookInCollectionAPI("66278f1b7ebcbd88a1b8c761", _isbncontroller.value.text); 
                   Navigator.pop(context);
                  } ,
                  child: WidgetsModels.button1(130, 35, ColorPalette.Secondary_Color_Orignal, FluentIcons.arrow_clockwise_dashes_16_filled, ColorPalette.SH_Grey100, "Add this book")
                  )
                else WidgetsModels.button1(130, 35, ColorPalette.SH_Grey500, FluentIcons.arrow_clockwise_dashes_16_filled, ColorPalette.SH_Grey300, "Add this book") 




             ],),
           )

       ],),
     ),
    );



    }
  }