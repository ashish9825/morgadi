import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BuySellState extends Equatable {}

class InitialBuySellState extends BuySellState {
  @override
  List<Object> get props => [];
}

class SellRequestState extends BuySellState {
  @override
  List<Object> get props => [];
}

class SellRequestedState extends BuySellState {
  @override
  List<Object> get props => [];
}

class BuyRequestState extends BuySellState {
  @override
  List<Object> get props => [];
}

class BuyRequestedState extends BuySellState {
  @override
  List<Object> get props => [];
}

class BuySellLoadingState extends BuySellState {
  @override
  List<Object> get props => [];
}

class BuySellExceptionState extends BuySellState {
  final String message;

  BuySellExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class BuySellNoNetworkState extends BuySellState {
  @override
  List<Object> get props => [];
}
