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
          center: {"x": 350, "y": 70},
          radius: 80,
          strokeWidth: 20,
          color: Color(0xFFfff7b3),
        ),
        Positioned(
          left: SizeConfig.blockSizeHorizontal * 45,
          top: SizeConfig.blockSizeHorizontal * 12,
          child: SvgPicture.asset(
            "images/personal_detail.svg",
            height: 200.0,
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
              minHeight: SizeConfig.blockSizeHorizontal * 0.6,
            ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Personal Details',
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: SizeConfig.blockSizeHorizontal * 6),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          Text(
            'Name',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.name,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: 'John Doe',
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          Text(
            'Email',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: 'johndoe@gmail.com',
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          Text(
            'City',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: 'Bilaspur',
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          Text(
            'Do You Own Any Car',
          ),
          Container(
            height: 40.0,
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
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  'Go Ahead',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.7),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFfdea9b),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
