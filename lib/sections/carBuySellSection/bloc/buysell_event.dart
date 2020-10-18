import 'package:equatable/equatable.dart';

class BuySellEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendSellRequestEvent extends BuySellEvent {
  final String car;
  final String model;
  final String variant;
  final String regNo;
  final String originYear;
  final String timeStamp;

  SendSellRequestEvent(this.car, this.model, this.variant, this.regNo,
      this.originYear, this.timeStamp);
}

class SellRequestSentEvent extends BuySellEvent {
  final String message;
  SellRequestSentEvent(this.message);
}

class SendBuyRequestEvent extends BuySellEvent {
  final String car;
  final String model;
  final String variant;
  final String originYearRange;
  final String timeStamp;

  SendBuyRequestEvent(
      this.car, this.model, this.variant, this.originYearRange, this.timeStamp);
}

class BuyRequestSentEvent extends BuySellEvent {
  final String message;
  BuyRequestSentEvent(this.message);
}

class BuySellExceptionEvent extends BuySellEvent {
  final String message;

  BuySellExceptionEvent(this.message);
}

class BuySellNoInternetEvent extends BuySellEvent {
  final String message;

  BuySellNoInternetEvent(this.message);
}
