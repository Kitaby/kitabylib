import 'package:flutter/material.dart';

import 'package:kitabylib/Mainscreen.dart';

import 'package:window_manager/window_manager.dart';



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
    return const MaterialApp(
      title: 'Kitabylib',
      debugShowCheckedModeBanner: false,
      home: Mainscreen(),
    );
  }
}