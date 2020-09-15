import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morgadi/sections/authenticate/ui/login_screen.dart';

void main() {
  runApp(MorgadiApp());
}

class MorgadiApp extends StatelessWidget {
  // This widget is the root of Morgadi application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Morgadi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFDD32A),
        fontFamily: "Poppins-Medium",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
