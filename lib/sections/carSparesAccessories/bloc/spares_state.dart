import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SparesState extends Equatable {}

class InitialSparesState extends SparesState {
  @override
  List<Object> get props => [];
}

class SparesRequestState extends SparesState {
  @override
  List<Object> get props => [];
}

class SparesRequestedState extends SparesState {
  @override
  List<Object> get props => [];
}

class SparesLoadingState extends SparesState {
  @override
  List<Object> get props => [];
}

class SparesExceptionState extends SparesState {
  final String message;

  SparesExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class SparesNoInternetState extends SparesState {
  @override
  List<Object> get props => [];
}
