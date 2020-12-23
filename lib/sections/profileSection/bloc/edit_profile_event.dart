import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditNameEvent extends EditProfileEvent {
  final String name;

  EditNameEvent(this.name);
}

class EditCityEvent extends EditProfileEvent {
  final String city;

  EditCityEvent(this.city);
}

class EditMailEvent extends EditProfileEvent {
  final String email;

  EditMailEvent(this.email);
}

class EditOwnCarEvent extends EditProfileEvent {
  final bool ownCar;

  EditOwnCarEvent(this.ownCar);
}

class EditSendOtpEvent extends EditProfileEvent {
  final String phoneNo;

  EditSendOtpEvent({this.phoneNo});
}

class EditVerifyOtpEvent extends EditProfileEvent {
  final String otp;

  EditVerifyOtpEvent({this.otp});
}

class EditOtpSendEvent extends EditProfileEvent {}

class EditPhoneEvent extends EditProfileEvent {
  final String phoneNumber;

  EditPhoneEvent(this.phoneNumber);
}

class EditUserCompletedEvent extends EditProfileEvent {
  final User firebaseUser;

  EditUserCompletedEvent(this.firebaseUser);
}

class EditPhoneCompleteEvent extends EditProfileEvent {
  final User firebaseUser;

  EditPhoneCompleteEvent(this.firebaseUser);
}

class EditCompletedEvent extends EditProfileEvent {
  final String message;

  EditCompletedEvent(this.message);
}

class SparesNoInternetEvent extends EditProfileEvent {
  final String message;

  SparesNoInternetEvent(this.message);
}

class EditExceptionEvent extends EditProfileEvent {
  final String message;

  EditExceptionEvent(this.message);
}
