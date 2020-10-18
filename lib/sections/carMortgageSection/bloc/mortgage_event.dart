import 'package:equatable/equatable.dart';

class MortgageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MortgageRequestEvent extends MortgageEvent {
  final String amount;
  final String car;
  final String model;
  final String variant;
  final String regNo;
  final String originYear;
  final String timeStamp;

  MortgageRequestEvent(this.amount, this.car, this.model, this.variant,
      this.regNo, this.originYear, this.timeStamp);
}

class MortgageRequestSentEvent extends MortgageEvent {
  final String message;

  MortgageRequestSentEvent(this.message);
}

class MortgageNoInternetEvent extends MortgageEvent {
  final String message;

  MortgageNoInternetEvent(this.message);
}
