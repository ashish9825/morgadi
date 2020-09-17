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
          center: {
            "x": SizeConfig.safeBlockHorizontal * 87,
            "y": SizeConfig.blockSizeVertical * 8
          },
          radius: SizeConfig.safeBlockHorizontal * 20,
          strokeWidth: SizeConfig.safeBlockHorizontal * 5,
          color: Color(0xFFfff7b3),
        ),
        Positioned(
          left: SizeConfig.blockSizeHorizontal * 20,
          top: SizeConfig.blockSizeVertical * 20,
          child: SvgPicture.asset(
            "images/city_driver1.svg",
            width: SizeConfig.blockSizeHorizontal * 80,
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {
              "x": SizeConfig.safeBlockHorizontal * 17,
              "y": SizeConfig.blockSizeVertical * 23
            },
            radius: SizeConfig.safeBlockHorizontal * 0.7,
            strokeWidth: SizeConfig.safeBlockHorizontal * 2.5,
            color: Color(0xFFFF7F98),
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {
              "x": SizeConfig.safeBlockHorizontal * 10,
              "y": SizeConfig.blockSizeVertical * 35
            },
            radius: SizeConfig.safeBlockHorizontal * 0.7,
            strokeWidth: SizeConfig.safeBlockHorizontal * 2.5,
            color: Color(0xFFFDE171),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical * 8,
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
                topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 13),
                topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 13),
              ),
            ),
            child: _signUpBody(),
          ),
        ),
      ],
    );
  }

  Widget _signUpBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal * 10,
          SizeConfig.blockSizeVertical * 5,
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
            height: SizeConfig.blockSizeVertical * 5,
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
                width: SizeConfig.safeBlockHorizontal * 5,
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
            height: SizeConfig.blockSizeVertical * 5,
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
                      vertical: SizeConfig.blockSizeVertical * 1.5),
                  child: Text(
                    'Get OTP',
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.7),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFfdea9b),
                borderRadius:
                    BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3.0,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
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
