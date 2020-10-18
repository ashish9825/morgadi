import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import '../data/buy_sell_repository.dart';
import 'buy_sell.dart';

class BuySellBloc extends Bloc<BuySellEvent, BuySellState> {
  final BuySellRepository _buySellRepository;

  String errorString = "";
  String verId = "";

  BuySellBloc({@required BuySellRepository buySellRepository})
      : assert(buySellRepository != null),
        _buySellRepository = buySellRepository,
        super(InitialBuySellState());

  @override
  Stream<BuySellState> mapEventToState(BuySellEvent event) async* {
    if (event is SendSellRequestEvent) {
      yield BuySellLoadingState();

      DataConnectionStatus status = await internetChecker();

      if (status == DataConnectionStatus.connected) {
        try {
          await _buySellRepository
              .registerToSell(event.car, event.model, event.variant,
                  event.regNo, event.originYear, event.timeStamp)
              .then((value) {
            this.verId = "Success";
          }).catchError((onError) {
            this.verId = "Error";
          });

          if (verId == "Success") {
            yield SellRequestedState();
          } else {
            yield BuySellExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield BuySellExceptionState(message: 'Some Error Occured');
          print(e);
        }
      } else {
        print('No Internet');
        yield BuySellNoNetworkState();
      }
    } else if (event is SellRequestSentEvent) {
      yield SellRequestedState();
    } else if (event is SendBuyRequestEvent) {
      yield BuySellLoadingState();

      DataConnectionStatus status = await internetChecker();
      if (status == DataConnectionStatus.connected) {
        try {
          await _buySellRepository
              .interestedInBuying(event.car, event.model, event.variant,
                  event.originYearRange, event.timeStamp)
              .then((value) {
            this.verId = "Success";
          }).catchError((onError) {
            this.verId = "Error";
          });

          if (verId == 'Success') {
            yield BuyRequestedState();
          } else {
            yield BuySellExceptionState(message: 'Some Error Occured');
          }
        } catch (e) {
          yield BuySellExceptionState(message: 'Some Error Occured');
        }
      } else {
        BuySellNoNetworkState();
      }
    } else if (event is BuyRequestSentEvent) {
      yield BuyRequestedState();
    } else if (event is BuySellExceptionEvent) {
      yield BuySellExceptionState(message: 'Some Error Occured');
    }
  }

  @override
  void onEvent(BuySellEvent event) {
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
    print('Buy Sell Bloc CLosed');
    super.close();
  }

  internetChecker() async {
    return await DataConnectionChecker().connectionStatus;
  }
}
