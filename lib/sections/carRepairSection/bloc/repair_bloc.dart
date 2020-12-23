import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morgadi/utils/utility_functions.dart';
import 'repair.dart';
import '../data/repair_repository.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  final RepairRepository _repairRepository;
    final UtilityFunction _utility;
  final FirebaseAuth _firebaseAuth;

  String errorString = "";
  String verId = "";

  RepairBloc({@required RepairRepository repairRepository})
      : assert(repairRepository != null),
        _repairRepository = repairRepository,
         _utility = UtilityFunction(),
        _firebaseAuth = FirebaseAuth.instance,
        super(InitialRepairState());

  Stream<DataConnectionStatus> _internetStream =
      DataConnectionChecker().onStatusChange;

  @override
  Stream<RepairState> mapEventToState(RepairEvent event) async* {
    if (event is RepairRequestEvent) {
      yield RepairLoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _repairRepository
              .requestForRepair(event.carBrand, event.carModel, event.otherCar,
                  event.problem, event.variant, event.regNo, event.timeStamp)
              .then((value) {
            this.verId = 'Success';
          }).catchError((onError) {
            this.verId = 'Error';
          });

          if (verId == 'Success') {
            yield RepairRequestedState();
                        _utility.launchWhatsapp(
                'UserId: ${_firebaseAuth.currentUser.uid},\nCar: ${event.carBrand} ${event.carModel} ${event.otherCar},\n Request: Repair Request');
          } else {
            yield RepairExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield RepairExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        yield RepairNoInternetState();
      }
    } else if (event is RepairRequestSentEvent) {
      yield RepairRequestedState();
    } else {
      yield RepairExceptionState(message: 'Some Error Occured');
    }
  }

  @override
  void onEvent(RepairEvent event) {
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
    print('Repair Bloc CLosed');
    super.close();
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }

  Stream<DataConnectionStatus> get internetStream => _internetStream;
}
