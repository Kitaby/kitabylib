import 'package:flutter/material.dart';

import 'package:kitabylib/Mainscreen.dart';

import 'package:window_manager/window_manager.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kitabylib/AppIntro/SplashScreen.dart';
import 'package:kitabylib/Forgotyourpassword/forgotyourpassword.dart';
import 'package:kitabylib/Forgotyourpassword/forgotyourpassword2.dart';

import 'package:kitabylib/Login.dart';
import 'package:kitabylib/SignUp/SignUp1.dart';
import 'package:kitabylib/SignUp/SignUp2.dart';
import 'package:kitabylib/SignUp/SignUp3.dart';




void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    
    center: true,
    windowButtonVisibility: true,
    size:Size(1920,1080) ,
    minimumSize:  Size(960,720),
    titleBarStyle: TitleBarStyle.normal,
   
    title: 'Kitabylib'
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Kitabylib',
      debugShowCheckedModeBanner: false,
      home:SignUp1(),
      routes: {
        
        'Forgotyourpassword' : (context) => Forgotyourpassword(oldmail: "") ,
        'SignUp1' : (context) => SignUp1() ,
        'SignUp2' : (context) => Signup2(phone: "", name: "") ,
        'SignUp3' : (context) => Signup3(phone: "", email: "", password: "", name: "") ,
      },
    );
  }
}