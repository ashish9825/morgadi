import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:morgadi/sections/authenticate/data/user_repository.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(InitialAuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.getUser() != null;

      if (hasToken) {
        print('EVENT1 : $event');
        yield Authenticated();
      } else {
        print('EVENT2 : $event');
        yield Unauthenticated();
      }
    } else if (event is LoggedIn) {
      print('EVENT3 : $event');
      yield Loading();
      yield Authenticated();
    } else if (event is LoggedOut) {
      print('EVENT4: $event');
      yield Loading();
      yield Unauthenticated();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
