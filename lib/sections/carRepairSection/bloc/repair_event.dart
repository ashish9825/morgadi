import 'package:equatable/equatable.dart';

class RepairEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RepairRequestEvent extends RepairEvent {
  final String carBrand;
  final String carModel;
  final String otherCar;
  final String problem;
  final String variant;
  final String regNo;
  final String timeStamp;

  RepairRequestEvent(this.carBrand, this.carModel, this.otherCar, this.problem,
      this.variant, this.regNo, this.timeStamp);
}

class RepairRequestSentEvent extends RepairEvent {
  final String message;

  RepairRequestSentEvent(this.message);
}

class RepairNoInternetEvent extends RepairEvent {
  final String message;

  RepairNoInternetEvent(this.message);
}
