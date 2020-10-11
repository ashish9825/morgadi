import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/bloc/authentication_state.dart';
import 'package:morgadi/sections/authenticate/bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/loginBloc/bloc.dart';
import 'package:morgadi/sections/authenticate/ui/number_verify.dart';
import 'package:morgadi/sections/homeSection/ui/home.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class SignupPage extends StatelessWidget {
  final LoginState loginState;
  final LoginBLoc loginBLoc;

  SignupPage({Key key, @required this.loginBLoc, this.loginState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBLoc>(
      create: (context) => loginBLoc,
      child: SignupScreen(loginBLoc: loginBLoc),
    );
  }
}

class SignupScreen extends StatelessWidget {
  LoginBLoc loginBLoc;

  SignupScreen({this.loginBLoc});
  var _formKey = GlobalKey<FormState>();
  var _phoneController = TextEditingController();

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
        cubit: loginBLoc,
        listener: (context, signupState) {
          print('STATESSS; $signupState');
          if (signupState is ExceptionState ||
              signupState is OtpExceptionState) {
            String message;
            if (signupState is ExceptionState) {
              message = signupState.message;
            } else if (signupState is OtpExceptionState) {
              message = signupState.message;
            }
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(message)),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          } else if (signupState is OtpSentState) {
            Future.delayed(Duration.zero, () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumberVerify(
                    loginState: signupState,
                    loginBLoc: loginBLoc,
                    phoneNumber: '+91' + _phoneController.text,
                  ),
                ),
              );
            });
          }
        },
        child: BlocBuilder<LoginBLoc, LoginState>(
          builder: (context, state) {
            return Container(
              color: Colors.yellow[100],
              child: _signupBody(state, context),
            );
          },
        ),
      ),
    );
  }

  Widget _signupBody(LoginState state, BuildContext context) {
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
                  topRight:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 13),
                ),
              ),
              child: getViewAsPerState(state, context)),
        ),
      ],
    );
  }

  getViewAsPerState(LoginState state, BuildContext context) {
    print('STAtE: $state');
    if (state is SignupFirstState) {
      return _signUpBody(state, context);
    } else if (state is LoadingState) {
      return _loadingIndicator();
    } else if (state is LoginCompleteState) {
      Future.delayed(Duration.zero, () async {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(LoggedIn(token: state.getUser().uid));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    } else {
      return _signUpBody(state, context);
    }
  }

  Widget _signUpBody(LoginState state, BuildContext context) {
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
            controller: _phoneController,
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
            validator: (value) {
              return validateMobile(value);
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          InkWell(
            onTap: () {
              print('PhoneControllerText : ${_phoneController.text}');
              BlocProvider.of<LoginBLoc>(context)
                  .add(SendOtpEvent(phoneNo: '+91' + _phoneController.text));
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

  String validateMobile(String value) {
    //Indian Mobile Numbers are of 10 digits.
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digits';
    } else {
      return null;
    }
  }

  Widget _loadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRipple(
            color: Colors.black,
            size: SizeConfig.blockSizeHorizontal * 20,
            borderWidth: SizeConfig.blockSizeHorizontal * 3,
          ),
        ],
      ),
    );
  }
}
