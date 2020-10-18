import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../data/rent_repository.dart';
import 'rent.dart';

class RentBloc extends Bloc<RentEvent, RentState> {
  final RentRepository _rentRepository;

  String errorString = "";
  String verId = "";

  RentBloc({@required RentRepository rentRepository})
      : assert(rentRepository != null),
        _rentRepository = rentRepository,
        super(InitialRentState());

  BehaviorSubject<DataConnectionStatus> _subject =
      DataConnectionChecker().onStatusChange;

  @override
  Stream<RentState> mapEventToState(RentEvent event) async* {
    if (event is SendRequestEvent) {
      yield LoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _rentRepository
              .requestForCarRent(event.carName, event.source, event.destination,
                  event.date, event.time, event.price, event.distance)
              .then((value) {
            this.verId = "Success";
          }).catchError((onError) {
            this.verId = 'Error';
          });

          if (verId == "Success") {
            yield RentRequestedState();
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
    _subject.close();
    super.close();
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }

  connectivityStream() {
    var listener = DataConnectionChecker().onStatusChange;
  }
}
