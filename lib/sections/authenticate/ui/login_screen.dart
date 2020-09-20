import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/paints/circle_painter.dart';
import 'package:morgadi/paints/hollow_circle_painter.dart';
import 'package:morgadi/sections/authenticate/bloc/authentication_state.dart';
import 'package:morgadi/sections/authenticate/data/user_repository.dart';
import 'package:morgadi/sections/authenticate/loginBloc/bloc.dart';
import 'package:morgadi/sections/authenticate/ui/number_verify.dart';
import 'package:morgadi/sections/authenticate/ui/signup_screen.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBLoc>(
      create: (context) => LoginBLoc(userRepository: userRepository),
      child: LoginScreen(userRepository),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final UserRepository userRepository;

  LoginScreen(this.userRepository);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBLoc _loginBLoc;
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();

  @override
  void initState() {
    _loginBLoc = BlocProvider.of<LoginBLoc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.yellow[100],
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBLoc, LoginState>(
        cubit: _loginBLoc,
        listener: (context, loginState) {
          print('STATESSS; $loginState');
          if (loginState is ExceptionState || loginState is OtpExceptionState) {
            String message;
            if (loginState is ExceptionState) {
              message = loginState.message;
            } else if (loginState is OtpExceptionState) {
              message = loginState.message;
            } else if (loginState is OtpSentState ||
                loginState is OtpExceptionState) {
              Future.delayed(Duration.zero, () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NumberVerify(
                      loginState: loginState,
                      loginBLoc: _loginBLoc,
                      // userRepository: widget.userRepository,
                    ),
                  ),
                );
              });
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
          } else if (loginState is OtpSentState) {
            Future.delayed(Duration.zero, () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NumberVerify(
                    loginState: loginState,
                    loginBLoc: _loginBLoc,
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
              child: _loginBody(state),
            );
          },
        ),
      ),
    );
  }

  Widget _loginBody(LoginState state) {
    return Stack(
      children: [
        Circle(
          center: {
            "x": SizeConfig.blockSizeHorizontal * 87,
            "y": SizeConfig.blockSizeVertical * 8
          },
          radius: SizeConfig.blockSizeHorizontal * 20,
          strokeWidth: SizeConfig.blockSizeHorizontal * 5,
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
              "x": SizeConfig.blockSizeHorizontal * 17,
              "y": SizeConfig.blockSizeVertical * 23
            },
            radius: SizeConfig.blockSizeHorizontal * 0.7,
            strokeWidth: SizeConfig.blockSizeHorizontal * 2.5,
            color: Color(0xFFFF7F98),
          ),
        ),
        Positioned(
          child: HollowCircle(
            center: {
              "x": SizeConfig.blockSizeHorizontal * 10,
              "y": SizeConfig.blockSizeVertical * 35
            },
            radius: SizeConfig.blockSizeHorizontal * 0.7,
            strokeWidth: SizeConfig.blockSizeHorizontal * 2.5,
            color: Color(0xFFFDE171),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical * 8,
          left: SizeConfig.blockSizeHorizontal * 5,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            child: Text(
              'Welcome Back !',
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
            child: getViewAsPerState(state),
          ),
        ),
      ],
    );
  }

  getViewAsPerState(LoginState state) {
    print('STAtE: $state');
    if (state is Unauthenticated) {
      return _signInBody(state);
    } else if (state is LoadingState) {
      return _loadingIndicator();
    } else if (state is LoginCompleteState) {
      print('Login State: $state');
    } else {
      return _signInBody(state);
    }
  }

  Widget _signInBody(LoginState state) {
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
            'Sign in',
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
            controller: _phoneTextController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            maxLength: 10,
            decoration: numberTextDecoration.copyWith(
              prefixIcon: SizedBox(
                width: SizeConfig.blockSizeHorizontal * 5,
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
              BlocProvider.of<LoginBLoc>(context).add(SendOtpEvent(
                  phoneNo: '+91' + _phoneTextController.value.text));
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
                    BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupPage(
                            loginBLoc: _loginBLoc,
                            loginState: state,
                          )));
            },
            child: Container(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'New User?',
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Medium"),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign up',
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

  @override
  void dispose() {
    _loginBLoc.close();
    super.dispose();
  }
}
