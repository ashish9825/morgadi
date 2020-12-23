import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/carSparesAccessories/bloc/spares_bloc.dart';
import 'package:morgadi/sections/carSparesAccessories/bloc/spares_event.dart';
import 'package:morgadi/sections/carSparesAccessories/bloc/spares_state.dart';
import 'package:morgadi/utils/size_config.dart';

class SparesDialog extends StatelessWidget {
  final SparesBloc sparesBloc;
  final String partName;
  final String car;
  final String model;
  final String otherCar;
  final String variant;
  final String originYear;

  SparesDialog({
    @required this.sparesBloc,
    @required this.partName,
    @required this.car,
    @required this.model,
    @required this.otherCar,
    @required this.variant,
    @required this.originYear,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sparesBloc,
      child: SparesConfirm(
        sparesBloc: sparesBloc,
        partName: partName,
        car: car,
        model: model,
        otherCar: otherCar,
        variant: variant,
        originYear: originYear,
      ),
    );
  }
}

class SparesConfirm extends StatelessWidget {
  final SparesBloc sparesBloc;
  final String partName;
  final String car;
  final String model;
  final String otherCar;
  final String variant;
  final String originYear;

  SparesConfirm({
    @required this.sparesBloc,
    @required this.partName,
    @required this.car,
    @required this.model,
    @required this.otherCar,
    @required this.variant,
    @required this.originYear,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocListener<SparesBloc, SparesState>(
        cubit: sparesBloc,
        listener: (context, repairState) {
          if (repairState is SparesExceptionState) {
            String message;
            message = repairState.message;

            print('Error: $message');
          }
        },
        child: BlocBuilder<SparesBloc, SparesState>(
          cubit: sparesBloc,
          builder: (context, state) => getViewAsPerState(state, context),
        ),
      ),
    );
  }

  getViewAsPerState(SparesState state, BuildContext context) {
    print('STATE: $state');
    if (state is InitialSparesState) {
      return _dialogContent(context);
    } else if (state is SparesLoadingState) {
      return _loadingIndicator();
    } else if (state is SparesRequestedState) {
      return _confirmedContent(context);
    } else if (state is SparesNoInternetState) {
      return _noInternetContent(context);
    } else {
      return _dialogContent(context);
    }
  }

  Widget _dialogContent(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            otherCar == " "
                ? 'Parts of of $car $model'
                : 'Parts of $car $otherCar',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
          ),
          Container(
            color: Color(0xFFFF7F98),
            height: SizeConfig.blockSizeHorizontal,
            width: SizeConfig.blockSizeHorizontal * 5,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          RichText(
            text: TextSpan(
                text: 'Do you want to confirm the request for parts of ',
                style: TextStyle(
                    color: Colors.black, fontFamily: "Poppins-Medium"),
                children: <TextSpan>[
                  TextSpan(
                      text: otherCar == " " ? '$car $model' : '$car $model',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: '.'),
                ]),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                InkWell(
                  onTap: () {
                    sparesBloc.add(
                      SparesRequestEvent(
                        partName,
                        car,
                        model,
                        otherCar,
                        variant,
                        originYear,
                        DateTime.now().toString(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2,
                        vertical: SizeConfig.blockSizeVertical * 1),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeHorizontal * 2),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            height: SizeConfig.blockSizeVertical * 30,
            width: SizeConfig.blockSizeHorizontal * 50,
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
