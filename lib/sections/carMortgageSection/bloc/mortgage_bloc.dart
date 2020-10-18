import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import '../data/mortgage_repository.dart';
import 'mortgage.dart';

class MortgageBloc extends Bloc<MortgageEvent, MortgageState> {
  final MortgageRepository _mortgageRepository;

  String errorString = "";
  String verId = "";

  MortgageBloc({@required MortgageRepository mortgageRepository})
      : assert(mortgageRepository != null),
        _mortgageRepository = mortgageRepository,
        super(InitialMortgageState());

  @override
  Stream<MortgageState> mapEventToState(MortgageEvent event) async* {
    if (event is MortgageRequestEvent) {
      yield MortgageLoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _mortgageRepository
              .requestForMortgage(event.amount, event.car, event.model,
                  event.variant, event.regNo, event.originYear, event.timeStamp)
              .then((value) {
            this.verId = 'Success';
          }).catchError((onError) {
            this.verId = 'Error';
          });

          if (verId == 'Success') {
            yield MortgageRequestedState();
          } else {
            yield MortgageExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield MortgageExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield MortgageNoInternetState();
      }
    } else if (event is MortgageRequestSentEvent) {
      yield MortgageRequestedState();
    } else {
      yield MortgageExceptionState(message: 'Some Error Occured');
    }
  }

  @override
  void onEvent(MortgageEvent event) {
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
    print('Mortgage Bloc CLosed');
    super.close();
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }
}
