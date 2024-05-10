import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kitabylib/AppIntro/SplashScreen.dart';
import 'package:kitabylib/Forgotyourpassword/forgotyourpassword.dart';
import 'package:kitabylib/Forgotyourpassword/forgotyourpassword2.dart';
import 'package:kitabylib/Home.dart';
import 'package:kitabylib/Login.dart';
import 'package:kitabylib/SignUp/SignUp1.dart';
import 'package:kitabylib/SignUp/SignUp2.dart';
import 'package:kitabylib/SignUp/SignUp3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signup3(phone: "phone", email: "email", password: "password", name: "name"),
      routes: {
        'Home' : (context) => Home(),
        'Forgotyourpassword' : (context) => Forgotyourpassword(oldmail: "") ,
        'SignUp1' : (context) => SignUp1() ,
        'SignUp2' : (context) => Signup2(phone: "", name: "") ,
        'SignUp3' : (context) => Signup3(phone: "", email: "", password: "", name: "") ,
      },
    );
  }
}