import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morgadi/app.dart';
import 'package:morgadi/simple_bloc_observer.dart';
import 'sections/authenticate/bloc/bloc.dart';
import 'sections/authenticate/data/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(MorgadiApp(userRepository: UserRepository()));
}

class MorgadiApp extends StatelessWidget {
  final UserRepository _userRepository;

  MorgadiApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  // This widget is the root of Morgadi application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return RepositoryProvider.value(
      value: _userRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(_userRepository)..add(AppStarted()),
        child: App(userRepository: _userRepository),
      ),
    );
  }
}
