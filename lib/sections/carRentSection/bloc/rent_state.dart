import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RentState extends Equatable {}

class InitialRentState extends RentState {
  @override
  List<Object> get props => [];
}

class RentRequestState extends RentState {
  @override
  List<Object> get props => [];
}

class RentRequestedState extends RentState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RentState {
  @override
  List<Object> get props => [];
}

class RentExceptionState extends RentState {
  final String message;

  RentExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class RentNoInternetState extends RentState {
  @override
  List<Object> get props => [];
}
