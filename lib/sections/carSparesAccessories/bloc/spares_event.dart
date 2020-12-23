import 'package:equatable/equatable.dart';

class SparesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SparesRequestEvent extends SparesEvent {
  final String partName;
  final String car;
  final String model;
  final String otherCar;
  final String variant;
  final String originYear;
  final String timeStamp;

  SparesRequestEvent(this.partName, this.car, this.model, this.otherCar,
      this.variant, this.originYear, this.timeStamp);
}

class SparesRequestSentEvent extends SparesEvent {
  final String message;

  SparesRequestSentEvent(this.message);
}

class SparesNoInternetEvent extends SparesEvent {
  final String message;

  SparesNoInternetEvent(this.message);
}
