import 'package:equatable/equatable.dart';

class RentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendRequestEvent extends RentEvent {
  final String carName;
  final String source;
  final String destination;
  final String date;
  final String time;
  final String price;
  final int distance;

  SendRequestEvent(this.carName, this.source, this.destination, this.date,
      this.time, this.price, this.distance);
}

class RequestSentEvent extends RentEvent {
  final String message;
  RequestSentEvent(this.message);
}

class RentExceptionEvent extends RentEvent {
  final String message;

  RentExceptionEvent(this.message);
}

class RentNoInternetEvent extends RentEvent {
  final String message;

  RentNoInternetEvent(this.message);
}
