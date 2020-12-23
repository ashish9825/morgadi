import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morgadi/sections/profileSection/data/profile_repository.dart';
import 'edit_profile.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepository _profileRepository;
  StreamSubscription editSubscription;

  String errorString = "";
  String verId = "";
  String verCode = "";

  EditProfileBloc({@required ProfileRepository profileRepository})
      : assert(profileRepository != null),
        _profileRepository = profileRepository,
        super(InitialEditState());

  Stream<DataConnectionStatus> _internetStream =
      DataConnectionChecker().onStatusChange;

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is EditNameEvent) {
      yield EditLoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          User user = await _profileRepository.updateName(event.name);

          if (user != null) {
            yield EditNameCompletedState(user);
          } else {
            yield EditExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield EditExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield EditNoInternetState();
      }
    } else if (event is EditCityEvent) {
      yield EditLoadingState();
      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _profileRepository.updateCity(event.city).then((value) {
            this.verCode = 'Success';
          }).catchError((onError) {
            this.verCode = 'Error';
          });

          if (verCode == 'Success') {
            yield EditCityCompletedState();
          } else {
            yield EditExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield EditExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield EditNoInternetState();
      }
    } else if (event is EditMailEvent) {
      yield EditLoadingState();
      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _profileRepository.updateEmail(event.email).then((value) {
            this.verCode = 'Success';
          }).catchError((onError) {
            this.verCode = 'Error';
          });

          if (verCode == 'Success') {
            yield EditMailCompletedState();
          } else {
            yield EditExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield EditExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield EditNoInternetState();
      }
    } else if (event is EditOwnCarEvent) {
      yield EditLoadingState();
      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _profileRepository.updateOwnCar(event.ownCar).then((value) {
            this.verCode = 'Success';
          }).catchError((onError) {
            this.verCode = 'Error';
          });

          if (verCode == 'Success') {
            yield EditOwnCarCompletedState();
          } else {
            yield EditExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield EditExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield EditNoInternetState();
      }
    } else if (event is EditSendOtpEvent) {
      yield EditLoadingState();
      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        editSubscription = updatePhoneNumber(event.phoneNo).listen((event) {
          add(event);
        });
      } else {
        yield EditNoInternetState();
      }
    } else if (event is EditOtpSendEvent) {
      yield EditOtpSentState();
    } else if (event is EditPhoneCompleteEvent) {
      yield EditPhoneCompletedState(event.firebaseUser);
    } else if (event is EditExceptionEvent) {
      yield EditExceptionState(message: errorString);
    } else if (event is EditVerifyOtpEvent) {
      yield EditLoadingState();

      try {
        User user =
            await _profileRepository.verifyAndUpdatePhone(verId, event.otp);

        if (user != null) {
          yield EditPhoneCompletedState(user);
        } else {
          yield EditOtpExceptionState(message: 'Invalid Otp !');
        }
      } catch (e) {
        yield EditOtpExceptionState(message: 'Invalid Otp !');
        print(e);
      }
    } else if (event is EditCompletedEvent) {
      yield EditCityCompletedState();
    } else {
      yield EditExceptionState(message: 'Some Error Occured');
    }
  }

  @override
  void onEvent(EditProfileEvent event) {
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
    print('Edit Profile Bloc CLosed');
    super.close();
  }

  Stream<EditProfileEvent> updatePhoneNumber(String phoneNumber) async* {
    StreamController<EditProfileEvent> eventStream = StreamController();

    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _profileRepository.updateNumber(authCredential);
      _profileRepository.getUser();
      _profileRepository.getUser().catchError((onError) {
        print('ERRORRRR: $onError');
      }).then((user) {
        eventStream.add(EditPhoneCompleteEvent(user));
        eventStream.close();
      });
    };

    final phoneVerificationFailed = (FirebaseAuthException authException) {
      errorString = authException.message;
      print('ERRORRRR: $errorString');
      print(authException.message);
      eventStream.add(EditExceptionEvent(errorString));
      eventStream.close();
    };

    final phoneCodeSent = (String verId, [int forceResent]) {
      print('ERRORRRR: Hello');
      this.verId = verId;
      eventStream.add(EditOtpSendEvent());
    };

    final phoneCodeAutoRetrievalTimeout = (String verId) {
      print('ERRORRRR: Hi');
      this.verId = verId;
      eventStream.close();
    };

    await _profileRepository.updatePhoneNumber(
        phoneNumber,
        Duration(seconds: 30),
        phoneVerificationCompleted,
        phoneVerificationFailed,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }

  Stream<DataConnectionStatus> get internetStream => _internetStream;
}
