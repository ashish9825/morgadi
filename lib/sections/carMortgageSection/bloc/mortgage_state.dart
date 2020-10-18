import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MortgageState extends Equatable {}

class InitialMortgageState extends MortgageState {
  @override
  List<Object> get props => [];
}

class MortgageRequestState extends MortgageState {
  @override
  List<Object> get props => [];
}

class MortgageRequestedState extends MortgageState {
  @override
  List<Object> get props => [];
}

class MortgageLoadingState extends MortgageState {
  @override
  List<Object> get props => [];
}

class MortgageExceptionState extends MortgageState {
  final String message;

  MortgageExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class MortgageNoInternetState extends MortgageState {
  @override
  List<Object> get props => [];
}
