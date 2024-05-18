import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kitabylib/Notifications/BooksOnLoan.dart';
import 'package:kitabylib/Constants/Colors.dart';
import 'package:kitabylib/Dashbord/DashBoard.dart';
import 'package:kitabylib/Notifications/ExpiredBooks.dart';
import 'package:kitabylib/Notifications/LoanRequests.dart';
import 'package:kitabylib/Notifications/PendingBooks.dart';
import 'package:kitabylib/Notifications/RenewRequests.dart';
import 'package:kitabylib/SideBarMenu.dart';

class Mainscreen extends StatefulWidget{
  const Mainscreen({super.key});

 @override
  State<Mainscreen> createState()  => MainscreenState();
  }
  
class MainscreenState extends State<Mainscreen>{

  Map screens = {
    0 :const DashBoard(),
    1 : Container(),
    2 :const LoanRequests(),
    3 : const PendingBooks(),
    4 : const BooksOnLoan(),
    5 : const ExpiredBooks(),
    6 : const RenewRequests(),
    7 : Container(),
    8 : Container(),
  };

 

static  ValueNotifier<int> currentscreen =ValueNotifier<int>(5);


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
            const Expanded(
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
 
 