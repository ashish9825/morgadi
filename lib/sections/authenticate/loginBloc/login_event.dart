import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends LoginEvent {
  final String phoneNo;

  SendOtpEvent({this.phoneNo});
}

class AppStartEvent extends LoginEvent {}

class VerifyOtpEvent extends LoginEvent {
  final String otp;

  VerifyOtpEvent({this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class LoginCompleteEvent extends LoginEvent {
  final User firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent(this.message);
}

class SignupFirstEvent extends LoginEvent {
  final User firebaseUser;
  SignupFirstEvent(this.firebaseUser);
}

class SignupDataSentEvent extends LoginEvent {
  final String name;
  final String email;
  final String city;
  final bool ownCar;
  final String phoneNumber;

  SignupDataSentEvent(
      this.name, this.email, this.city, this.ownCar, this.phoneNumber);
}

class SignupCompleteEvent extends LoginEvent {
  final User firebaseUser;
  SignupCompleteEvent(this.firebaseUser);
}
