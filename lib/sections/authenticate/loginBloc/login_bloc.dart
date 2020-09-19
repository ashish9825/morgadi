import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/data/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class LoginBLoc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  StreamSubscription subscription;

  String verId = "";
  String errorString = "";

  LoginBLoc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();

      subscription = sendOtp(event.phoneNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: errorString);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        UserCredential result =
            await _userRepository.verifyAndLogin(verId, event.otp);

        if (result.user != null) {
          yield LoginCompleteState(result.user);
        } else {
          yield OtpExceptionState(message: 'Invalid Otp !');
        }
      } catch (e) {
        yield OtpExceptionState(message: 'Invalid Otp !');
        print(e);
      }
    }
  }

  @override
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(stackTrace);
  }

  @override
  Future<void> close() async {
    print('Bloc CLosed');
    super.close();
  }

  Stream<LoginEvent> sendOtp(String phoneNo) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };

    final phoneVerificationFailed = (FirebaseAuthException authException) {
      errorString = authException.message;
      print(authException.message);
      eventStream.add(LoginExceptionEvent(errorString));
      eventStream.close();
    };

    final phoneCodeSent = (String verId, [int forceResent]) {
      this.verId = verId;
      eventStream.add(OtpSendEvent());
    };

    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this.verId = verid;
      eventStream.close();
    };

    await _userRepository.sendOTP(
        phoneNo,
        Duration(seconds: 3),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
