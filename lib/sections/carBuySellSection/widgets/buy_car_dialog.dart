import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/carBuySellSection/bloc/buy_sell.dart';
import 'package:morgadi/sections/carBuySellSection/bloc/buysell_bloc.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class BuyCarDialog extends StatelessWidget {
  final BuySellBloc buySellBloc;

  BuyCarDialog({this.buySellBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => buySellBloc,
      child: BuyCarConfirm(
        buySellBloc: buySellBloc,
      ),
    );
  }
}

class BuyCarConfirm extends StatelessWidget {
  final BuySellBloc buySellBloc;

  BuyCarConfirm({@required this.buySellBloc});

  TextEditingController _carController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _variantController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocListener<BuySellBloc, BuySellState>(
        cubit: buySellBloc,
        listener: (context, buysellState) {
          if (buysellState is BuySellExceptionState) {
            String message;
            message = buysellState.message;

            print('Error: $message');
          }
        },
        child: BlocBuilder(
          cubit: buySellBloc,
          builder: (context, state) => getViewAsPerState(state, context),
        ),
      ),
    );
  }

  getViewAsPerState(BuySellState state, BuildContext context) {
    print('State : $state');
    if (state is InitialBuySellState) {
      return _dialogContent(context);
    } else if (state is BuySellLoadingState) {
      return _loadingIndicator();
    } else if (state is BuyRequestedState) {
      return _confirmedContent(context);
    } else if (state is BuySellNoNetworkState) {
      return _noInternetContent(context);
    }else {
      return _dialogContent(context);
    }
  }

  Container _dialogContent(BuildContext context) {
    return Container(
      // height: SizeConfig.blockSizeVertical * 65,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.blockSizeHorizontal * 5,
            SizeConfig.blockSizeVertical * 5,
            SizeConfig.blockSizeHorizontal * 5,
            0),
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, stateSetter) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car',
                ),
                TextFormField(
                  controller: _carController,
                  cursorColor: Colors.black,
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                  decoration: numberTextDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.4,
                        horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                    hintText: 'Hyundai Creta',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.5,
                ),
                Text(
                  'Preferred Model',
                ),
                TextFormField(
                  controller: _modelController,
                  cursorColor: Colors.black,
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                  decoration: numberTextDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.4,
                        horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                    hintText: 'SX Turbo 7 DCT',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.5,
                ),
                Text(
                  'Preferred Engine Variant',
                ),
                TextFormField(
                  controller: _variantController,
                  cursorColor: Colors.black,
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                  decoration: numberTextDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.4,
                        horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                    hintText: 'Petrol',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1.5,
                ),
                Text(
                  'Year Of Origin Range',
                ),
                TextFormField(
                  controller: _yearController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                  decoration: numberTextDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.4,
                        horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                    hintText: '2014 - 2016',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 10,
                ),
                InkWell(
                  onTap: () {
                    buySellBloc.add(SendBuyRequestEvent(
                        _carController.text,
                        _modelController.text,
                        _variantController.text,
                        _yearController.text,
                        DateTime.now().toString()));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4,
                          vertical: SizeConfig.blockSizeVertical * 2),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 2),
                      ),
                      child: Text(
                        'Interested in Buying',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
        bottom: SizeConfig.blockSizeVertical * 1.5,
        left: SizeConfig.blockSizeHorizontal * 4,
        right: SizeConfig.blockSizeHorizontal * 4,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitRipple(
              color: Colors.yellow,
              size: SizeConfig.blockSizeHorizontal * 20,
              borderWidth: SizeConfig.blockSizeHorizontal * 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmedContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
        bottom: SizeConfig.blockSizeVertical * 1.5,
        left: SizeConfig.blockSizeHorizontal * 4,
        right: SizeConfig.blockSizeHorizontal * 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 40,
            width: SizeConfig.blockSizeHorizontal * 60,
            child: Lottie.asset("assets/confirm_tick.json"),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 8,
                    vertical: SizeConfig.blockSizeVertical * 1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noInternetContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
        bottom: SizeConfig.blockSizeVertical * 1.5,
        left: SizeConfig.blockSizeHorizontal * 4,
        right: SizeConfig.blockSizeHorizontal * 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 40,
            width: SizeConfig.blockSizeHorizontal * 60,
            child: Lottie.asset("assets/no_internet.json"),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 8,
                    vertical: SizeConfig.blockSizeVertical * 1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
