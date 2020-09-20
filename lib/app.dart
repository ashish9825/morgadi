import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morgadi/sections/authenticate/bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/ui/signup_detail.dart';
import 'package:morgadi/sections/homeSection/ui/home.dart';
import 'package:morgadi/sections/splash/splash_screen.dart';

import 'sections/authenticate/data/user_repository.dart';
import 'sections/authenticate/ui/login_screen.dart';

class App extends StatefulWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  UserRepository get userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morgadi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFDD32A),
        fontFamily: "Poppins-Medium",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            print('A');
            return SplashScreen();
          } else if (state is Unauthenticated) {
            print('B');
            return LoginPage(userRepository: userRepository);
          } else if (state is Authenticated) {
            print('C');
            return Home();
          } else {
            print('D');
            print('STATE: $state');
            return SplashScreen();
          }
        },
      ),
    );
  }
}
