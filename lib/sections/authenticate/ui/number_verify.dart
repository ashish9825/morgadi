import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/bloc/authentication_bloc.dart';
import 'package:morgadi/sections/authenticate/bloc/authentication_event.dart';
import 'package:morgadi/sections/authenticate/loginBloc/bloc.dart';
import 'package:morgadi/sections/authenticate/ui/signup_detail.dart';
import 'package:morgadi/sections/homeSection/ui/home.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:morgadi/utils/utility_functions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NumberVerify extends StatelessWidget {
  final LoginState loginState;
  final LoginBLoc loginBLoc;

  NumberVerify({Key key, @required this.loginBLoc, this.loginState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBLoc>(
      create: (context) => loginBLoc,
      child: NumberVerifyState(
        loginBloc: loginBLoc,
        loginState: loginState,
      ),
    );
  }
}

class NumberVerifyState extends StatelessWidget {
  final LoginState loginState;
  final LoginBLoc loginBloc;

  NumberVerifyState({this.loginState, this.loginBloc});

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
          builder: (context, state) {
            return Container(
              color: Colors.yellow[100],
              child: _numberVerify(state, context),
            );
          },
        ),
      ),
    );
  }

  Widget _numberVerify(LoginState state, BuildContext context) {
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
          left: SizeConfig.blockSizeHorizontal * 30,
          top: SizeConfig.blockSizeVertical * 21,
          child: SvgPicture.asset(
            "images/phone_verify.svg",
            width: SizeConfig.safeBlockHorizontal * 60,
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
    print('STAtE1: $state');
    if (state is OtpSentState || state is OtpExceptionState) {
      return _verify(state, context);
    } else if (state is LoadingState) {
      return UtilityFunction().loadingIndicator(
          SizeConfig.blockSizeHorizontal * 20,
          SizeConfig.blockSizeHorizontal * 3,
          Colors.black);
    } else if (state is LoginCompleteState) {
      Future.delayed(Duration.zero, () async {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(LoggedIn(token: state.getUser().uid));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    } else if (state is SignupFirstState) {
      Future.delayed(Duration.zero, () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignupDetail()));
      });
    } else {
      return _verify(state, context);
    }
  }

  Widget _verify(LoginState state, BuildContext context) {
    print('SECOND STATE: $state');
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
            'Code Verification',
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: SizeConfig.blockSizeHorizontal * 6),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Text(
            'Enter Verification Code',
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2.5,
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
                borderRadius: BorderRadius.circular(
                    SizeConfig.safeBlockHorizontal * 1.5)),
            onCompleted: (pin) {
              BlocProvider.of<LoginBLoc>(context).add(VerifyOtpEvent(otp: pin));
            },
            onChanged: (value) {},
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
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
                          fontSize: SizeConfig.safeBlockHorizontal * 3.7),
                    )
                  ]),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2.5,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<LoginBLoc>(context).add(AppStartEvent());
            },
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 1.5),
                  child: Text(
                    'Verify',
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
        ],
      ),
    );
  }
}
