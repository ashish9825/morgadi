import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
          child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SvgPicture.asset("images/morgadi.svg"),
        ),
      ),
    );
  }
}
