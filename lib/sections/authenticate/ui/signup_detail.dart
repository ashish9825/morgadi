import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/bloc/authentication_bloc.dart';
import 'package:morgadi/sections/authenticate/bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/loginBloc/bloc.dart';
import 'package:morgadi/sections/authenticate/widgets/any_car.dart';
import 'package:morgadi/sections/homeSection/ui/home.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:morgadi/utils/utility_functions.dart';

class SignupDetailPage extends StatelessWidget {
  final LoginBLoc loginBLoc;
  final LoginState loginState;
  final String phoneNumber;

  SignupDetailPage(
      {this.loginBLoc, this.loginState, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBLoc>(
      create: (context) => loginBLoc,
      child: SignupDetail(
        loginState: loginState,
        loginBloc: loginBLoc,
        phoneNumber: phoneNumber,
      ),
    );
  }
}

class SignupDetail extends StatelessWidget {
  final LoginState loginState;
  final LoginBLoc loginBloc;
  final String phoneNumber;

  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _cityController = TextEditingController();
  bool ownCar = true;

  SignupDetail({this.loginState, this.loginBloc, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.yellow[100],
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBLoc, LoginState>(
        cubit: loginBloc,
        listener: (context, loginState) {
          if (loginState is ExceptionState || loginState is OtpExceptionState) {
            String message;
            if (loginState is ExceptionState) {
              message = loginState.message;
            } else if (loginState is OtpExceptionState) {
              message = loginState.message;
            }

            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(message), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder<LoginBLoc, LoginState>(
          cubit: loginBloc,
          builder: (context, state) => Container(
            color: Colors.yellow[100],
            child: _signupDetail(state, context),
          ),
        ),
      ),
    );
  }

  Widget _signupDetail(LoginState state, BuildContext context) {
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
            child: getViewAsPerState(state, context),
          ),
        ),
      ],
    );
  }

  getViewAsPerState(LoginState state, BuildContext context) {
    print('STATEInDetails: $state');
    if (state is OtpSentState || state is OtpExceptionState) {
      return _signUpDetailBody(state, context);
    } else if (state is LoadingState) {
      return UtilityFunction().loadingIndicator(
          SizeConfig.blockSizeHorizontal * 20,
          SizeConfig.blockSizeHorizontal * 3,
          Colors.black);
    } else if (state is SignupCompleteState) {
      Future.delayed(Duration.zero, () async {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(LoggedIn(token: state.getUser().uid));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    } else {
      return _signUpDetailBody(state, context);
    }
  }

  Widget _signUpDetailBody(LoginState state, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal * 10,
          SizeConfig.blockSizeVertical * 5,
          SizeConfig.blockSizeHorizontal * 10,
          0),
      child: SingleChildScrollView(
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
              controller: _nameController,
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
              controller: _emailController,
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
              controller: _cityController,
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
            StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) =>
                  Container(
                height: SizeConfig.blockSizeVertical * 4.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: yesOrNo.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        stateSetter(() {
                          yesOrNo
                              .forEach((element) => element.isSelected = false);
                          yesOrNo[index].isSelected = true;
                        });
                        ownCar = yesOrNo[0].isSelected == true
                            ? ownCar = true
                            : ownCar = false;
                      },
                      child: AnyCar(yesOrNo[index]),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            InkWell(
              onTap: () {
                print('PhoneNumber1: $phoneNumber');
                BlocProvider.of<LoginBLoc>(context).add(
                  SignupDataSentEvent(
                      _nameController.text,
                      _emailController.text,
                      _cityController.text,
                      ownCar,
                      phoneNumber),
                );
              },
              child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.5),
                    child: Text(
                      'Go Ahead',
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
            height: SizeConfig.blockSizeVertical * 2,
          ),
          ],
        ),
      ),
    );
  }
}
