import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EditProfileState extends Equatable {}

class InitialEditState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditLoadingState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditNameCompletedState extends EditProfileState {
  final User _firebaseUser;

  EditNameCompletedState(this._firebaseUser);

  User getUser() {
    return _firebaseUser;
  }

  @override
  List<Object> get props => [_firebaseUser];
}

class EditCityCompletedState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditMailCompletedState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditOwnCarCompletedState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditOtpSentState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditOtpVerifiedState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditPhoneCompletedState extends EditProfileState {
  final User _firebaseUser;

  EditPhoneCompletedState(this._firebaseUser);

  User getUser() {
    return _firebaseUser;
  }

  @override
  List<Object> get props => [_firebaseUser];
}

class EditExceptionState extends EditProfileState {
  final String message;

  EditExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class EditOtpExceptionState extends EditProfileState {
  final String message;

  EditOtpExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class EditNoInternetState extends EditProfileState {
  @override
  List<Object> get props => [];
}
