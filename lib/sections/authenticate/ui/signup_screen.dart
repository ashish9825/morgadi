import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/ui/number_verify.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.yellow[100],
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.yellow[100],
        child: _signupBody(),
      ),
    );
  }

  Widget _signupBody() {
    return Stack(
      children: [
        Circle(
          center: {"x": 350, "y": 70},
          radius: 80,
          strokeWidth: 20,
          color: Color(0xFFfff7b3),
        ),
        Positioned(
          left: SizeConfig.blockSizeHorizontal * 17,
          top: SizeConfig.blockSizeHorizontal * 40,
          child: SvgPicture.asset(
            "images/city_driver1.svg",
            height: 250.0,
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {"x": 70, "y": 200},
            radius: 3,
            strokeWidth: 10,
            color: Color(0xFFFF7F98),
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {"x": 40, "y": 300},
            radius: 3,
            strokeWidth: 10,
            color: Color(0xFFFDE171),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeHorizontal * 16,
          left: SizeConfig.blockSizeHorizontal * 5,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            child: Text(
              'Let\'s Start !',
              style: TextStyle(
                fontFamily: "Poppins-Medium",
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal * 7,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: SizeConfig.screenHeight * 0.5,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: _signInBody(),
          ),
        ),
      ],
    );
  }

  Widget _signInBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal * 10,
          SizeConfig.blockSizeHorizontal * 10,
          SizeConfig.blockSizeHorizontal * 10,
          0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign up',
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: SizeConfig.blockSizeHorizontal * 6),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          Text(
            'Enter Your Mobile Number',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            maxLength: 10,
            decoration: numberTextDecoration.copyWith(
              prefixIcon: SizedBox(
                width: 20.0,
                child: Center(
                  child: Text(
                    '+91',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.blockSizeHorizontal * 4),
                  ),
                ),
              ),
              counter: Container(),
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NUmberVerifyScreen()));
            },
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeHorizontal * 3),
                  child: Text(
                    'Get OTP',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.7),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFfdea9b),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 5,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already a User?',
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Medium"),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign in',
                        style: TextStyle(color: Color(0xFFFF7F98)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
