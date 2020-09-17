import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/data/user_repository.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(null);

  
  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.getUser() != null;

      if (hasToken) {
        yield Authenticated();
      } else {
        Unauthenticated();
      }
    } else if (event is LoggedIn) {
      yield Loading();
      yield Authenticated();
    } else if (event is LoggedOut) {
      yield Loading();
      yield Unauthenticated();
    }
  }
}
