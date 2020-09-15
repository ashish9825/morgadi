import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/ui/signup_detail.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NUmberVerifyScreen extends StatefulWidget {
  @override
  _NumberVerifyState createState() => _NumberVerifyState();
}

class _NumberVerifyState extends State<NUmberVerifyScreen> {
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
          left: SizeConfig.blockSizeHorizontal * 30,
          top: SizeConfig.blockSizeHorizontal * 45,
          child: SvgPicture.asset(
            "images/phone_verify.svg",
            height: 220.0,
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
              'Verify Phone !',
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
            'Code Verification',
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: SizeConfig.blockSizeHorizontal * 6),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          Text(
            'Enter Verification Code',
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 5,
          ),
          PinCodeTextField(
            appContext: context,
            length: 6,
            obsecureText: false,
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 300),
            enableActiveFill: true,
            textInputType: TextInputType.number,
            pinTheme: PinTheme.defaults(
                shape: PinCodeFieldShape.box,
                activeColor: Colors.grey[200],
                activeFillColor: Colors.grey[200],
                disabledColor: Colors.grey[200],
                inactiveColor: Colors.grey[200],
                selectedColor: Colors.grey[200],
                inactiveFillColor: Colors.grey[200],
                selectedFillColor: Colors.grey[200],
                borderRadius: BorderRadius.circular(5.0)),
            onChanged: (value) {},
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Didn't receive the code?",
                  style: TextStyle(
                      color: Colors.black54, fontFamily: "Poppins-Medium"),
                  children: [
                    TextSpan(
                        text: " Resend",
                        style: TextStyle(
                            color: Color(0xFF91D3B3),
                            fontWeight: FontWeight.bold,
                            fontSize: 16))
                  ]),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 5,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupDetail()));
            },
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeHorizontal * 3),
                  child: Text(
                    'Verify',
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
        ],
      ),
    );
  }
}
