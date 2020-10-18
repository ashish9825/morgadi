import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RepairState extends Equatable {}

class InitialRepairState extends RepairState {
  @override
  List<Object> get props => [];
}

class RepairRequestState extends RepairState {
  @override
  List<Object> get props => [];
}

class RepairRequestedState extends RepairState {
  @override
  List<Object> get props => [];
}

class RepairLoadingState extends RepairState {
  @override
  List<Object> get props => [];
}

class RepairExceptionState extends RepairState {
  final String message;

  RepairExceptionState({this.message});

  @override
  List<Object> get props => [message];
}

class RepairNoInternetState extends RepairState {
  @override
  List<Object> get props => [];
}
