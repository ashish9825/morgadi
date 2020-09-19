import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {
  @override
  String toString() => 'InititalAuthenticationState';
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class Loading extends AuthenticationState {
  @override
  String toString() => 'Loading';
}
