import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/data/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morgadi/utils/preferences.dart';
import 'bloc.dart';

class LoginBLoc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  StreamSubscription subscription;
  final Preferences prefs = Preferences();

  String verId = "";
  String errorString = "";
  bool newUser = false;

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
    } 
    
    // else if (event is LoginCompleteEvent) {
    //   yield LoginCompleteState(event.firebaseUser);
    // } 
    
    else if (event is SignupFirstEvent) {
      yield SignupFirstState(event.firebaseUser);
    } else if (event is SignupDataSentEvent) {
      yield LoadingState();
      try {
        User user =
            await _userRepository.getUpdatedUser(event.name, event.email);

        await _userRepository.addUser(event.name, event.phoneNumber,
            event.email, event.city, event.ownCar);

        await prefs.saveBasicUserDetails(event.city, event.email, event.name,
            event.ownCar, event.phoneNumber);

        if (user != null) {
          yield SignupCompleteState(user);
        } else {
          yield ExceptionState(message: 'Some Error Occured');
        }
      } catch (e) {
        yield ExceptionState(message: 'Some Error Occured');
        print(e);
      }
    } else if (event is SignupCompleteEvent) {
      yield SignupCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: errorString);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        UserCredential result =
            await _userRepository.verifyAndLogin(verId, event.otp);

        final bool userExists = await _userRepository.checkIfUserExists();

        if (result.user != null) {
          print('NEW USER: ${result.additionalUserInfo.isNewUser}');
          if (result.additionalUserInfo.isNewUser) {
            print('New User');
            this.newUser = true;
            yield SignupFirstState(result.user);
          } else {
            if (userExists) {
                print('User Exists');
              yield LoginCompleteState(result.user);
            } else {
              print('User Does Not Exists');
              yield SignupFirstState(result.user);
            }
          }
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
        if (this.newUser) {
          eventStream.add(SignupFirstEvent(user));
          eventStream.close();
        } else {
          eventStream.add(LoginCompleteEvent(user));
          eventStream.close();
        }
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
