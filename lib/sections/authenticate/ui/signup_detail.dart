import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/model/any_car_item.dart';
import 'package:morgadi/sections/authenticate/widgets/any_car.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class SignupDetail extends StatefulWidget {
  @override
  _SignupDetailState createState() => _SignupDetailState();
}

class _SignupDetailState extends State<SignupDetail> {
  List<AnyCarItem> yesOrNo = List<AnyCarItem>();

  @override
  void initState() {
    super.initState();

    yesOrNo.add(AnyCarItem(
        true, 'Yes', Colors.grey[200], "images/yes.svg", Color(0xFFc8a104)));
    yesOrNo.add(AnyCarItem(
        false, 'No', Colors.grey[200], "images/no.svg", Color(0xFFc8a104)));
  }

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
        child: _signupDetail(),
      ),
    );
  }

  Widget _signupDetail() {
    return Stack(
      children: [
        Circle(
          center: {
            "x": SizeConfig.blockSizeHorizontal * 87,
            "y": SizeConfig.blockSizeVertical * 8
          },
          radius: SizeConfig.blockSizeHorizontal * 20,
          strokeWidth: SizeConfig.safeBlockHorizontal * 5,
          color: Color(0xFFfff7b3),
        ),
        Positioned(
          left: SizeConfig.blockSizeHorizontal * 45,
          top: SizeConfig.blockSizeVertical * 6,
          child: SvgPicture.asset(
            "images/personal_detail.svg",
            width: SizeConfig.blockSizeHorizontal * 55,
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {
              "x": SizeConfig.safeBlockHorizontal * 17,
              "y": SizeConfig.blockSizeVertical*23
            },
            radius: SizeConfig.safeBlockHorizontal * 0.7,
            strokeWidth: SizeConfig.safeBlockHorizontal * 2.5,
            color: Color(0xFFFF7F98),
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {
              "x": SizeConfig.blockSizeHorizontal * 10,
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
              'A Bit Personal !',
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
            height: SizeConfig.screenHeight * 0.7,
            width: SizeConfig.screenWidth,
            constraints: BoxConstraints(
              minHeight: SizeConfig.blockSizeVertical * 0.3,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 13),
                topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 13),
              ),
            ),
            child: _signUpDetailBody(),
          ),
        ),
      ],
    );
  }

  Widget _signUpDetailBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal * 10,
          SizeConfig.blockSizeVertical * 5,
          SizeConfig.blockSizeHorizontal * 10,
          0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Personal Details',
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: SizeConfig.blockSizeHorizontal * 6),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Text(
            'Name',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.name,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'John Doe',
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Email',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'johndoe@gmail.com',
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'City',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'Bilaspur',
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Do You Own Any Car',
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 4.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: yesOrNo.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      yesOrNo.forEach((element) => element.isSelected = false);
                      yesOrNo[index].isSelected = true;
                    });
                  },
                  child: AnyCar(yesOrNo[index]),
                );
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1.5),
                child: Text(
                  'Go Ahead',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.7),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFfdea9b),
              borderRadius:
                  BorderRadius.circular(SizeConfig.safeBlockHorizontal * 2),
            ),
          ),
        ],
      ),
    );
  }
}
