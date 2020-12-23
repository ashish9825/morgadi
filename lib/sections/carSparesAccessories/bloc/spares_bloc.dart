import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morgadi/utils/utility_functions.dart';
import '../data/spares_repository.dart';
import 'spares.dart';

class SparesBloc extends Bloc<SparesEvent, SparesState> {
  final SparesRepository _sparesRepository;
  final UtilityFunction _utility;
  final FirebaseAuth _firebaseAuth;

  String errorString = "";
  String verId = "";

  SparesBloc({@required SparesRepository sparesRepository})
      : assert(sparesRepository != null),
        _sparesRepository = sparesRepository,
        _utility = UtilityFunction(),
        _firebaseAuth = FirebaseAuth.instance,
        super(InitialSparesState());

  Stream<DataConnectionStatus> _internetStream =
      DataConnectionChecker().onStatusChange;

  @override
  Stream<SparesState> mapEventToState(SparesEvent event) async* {
    if (event is SparesRequestEvent) {
      yield SparesLoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _sparesRepository
              .requestForSpares(
            event.partName,
            event.car,
            event.model,
            event.otherCar,
            event.variant,
            event.originYear,
            event.timeStamp,
          )
              .then((value) {
            this.verId = 'Success';
          }).catchError((onError) {
            this.verId = 'Error';
          });

          if (verId == 'Success') {
            yield SparesRequestedState();
            _utility.launchWhatsapp(
                'UserId: ${_firebaseAuth.currentUser.uid},\nCar: ${event.car},\n Request: Spares Request');
          } else {
            yield SparesExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield SparesExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield SparesNoInternetState();
      }
    } else if (event is SparesRequestSentEvent) {
      yield SparesRequestedState();
    } else {
      yield SparesExceptionState(message: 'Some Error Occured');
    }
  }

  @override
  void onEvent(SparesEvent event) {
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
    print('Spares Bloc CLosed');
    super.close();
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }

  Stream<DataConnectionStatus> get internetStream => _internetStream;
}
