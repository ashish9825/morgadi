import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morgadi/utils/utility_functions.dart';
import '../data/rent_repository.dart';
import 'rent.dart';

class RentBloc extends Bloc<RentEvent, RentState> {
  final RentRepository _rentRepository;
   final UtilityFunction _utility;
  final FirebaseAuth _firebaseAuth;

  String errorString = "";
  String verId = "";

  RentBloc({@required RentRepository rentRepository})
      : assert(rentRepository != null),
        _rentRepository = rentRepository,
          _utility = UtilityFunction(),
        _firebaseAuth = FirebaseAuth.instance,
        super(InitialRentState());

  Stream<DataConnectionStatus> _internetStream =
      DataConnectionChecker().onStatusChange;

  @override
  Stream<RentState> mapEventToState(RentEvent event) async* {
    if (event is SendRequestEvent) {
      yield LoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _rentRepository
              .requestForCarRent(
                  event.carName,
                  event.source,
                  event.destination,
                  event.date,
                  event.time,
                  event.price,
                  event.distance,
                  event.timeStamp)
              .then((value) {
            this.verId = "Success";
          }).catchError((onError) {
            this.verId = 'Error';
          });

          if (verId == "Success") {
            yield RentRequestedState();
              _utility.launchWhatsapp(
                'UserId: ${_firebaseAuth.currentUser.uid},\nCar: ${event.carName},\n Request: Rent Request');
          } else {
            yield RentExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield RentExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield RentNoInternetState();
      }
    } else if (event is RequestSentEvent) {
      yield RentRequestedState();
    } else if (event is RentExceptionEvent) {
      yield RentExceptionState(message: 'Some Error Occured');
    }
  }

  @override
  void onEvent(RentEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(stackTrace);
  }

  @override
  Future<void> close() async {
    print('Rent Bloc CLosed');
    super.close();
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }

  connectivityStream() {
    var listener = DataConnectionChecker().onStatusChange;
  }

  Stream<DataConnectionStatus> get internetStream => _internetStream;
}
