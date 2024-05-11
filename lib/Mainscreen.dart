import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Dashbord/DashBoard.dart';
import 'package:kitabylib/SideBarMenu.dart';

class Mainscreen extends StatefulWidget{
  const Mainscreen({super.key});

 @override
  State<Mainscreen> createState()  => MainscreenState();
  }
  
class MainscreenState extends State<Mainscreen>{

  Map screens = {
    0 : const DashBoard(),
    1 : Container(),
    2 : Container(),
    3 : Container(),
    4 : Container(),
    5 : Container(),
    6 : Container(),
    7 : Container(),
  };

 

static  ValueNotifier<int> currentscreen =ValueNotifier<int>(0);


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentscreen.addListener(() { setState(() { });});
  }


  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child:SideBarMenu(), 
            ),
            Expanded(
              flex: 5,
              child: screens[currentscreen.value], 
            ),
            
          ],
        )),
    );
  }
  
  
}
 
 