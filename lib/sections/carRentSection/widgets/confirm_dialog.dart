import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/carRentSection/bloc/rent.dart';
import 'package:morgadi/utils/size_config.dart';

class ConfirmationDialog extends StatelessWidget {
  final RentBloc rentBloc;
  final String carName;
  final String source;
  final String destination;
  final String price;
  final String date;
  final String time;
  final int distance;

  ConfirmationDialog(
      {@required this.rentBloc,
      this.carName,
      this.source,
      this.destination,
      this.price,
      this.date,
      this.time,
      this.distance});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => rentBloc,
      child: ConfirmDialog(
          rentBloc: rentBloc,
          carName: carName,
          source: source,
          destination: destination,
          price: price,
          date: date,
          time: time,
          distance: distance),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final RentBloc rentBloc;
  final String carName;
  final String source;
  final String destination;
  final String price;
  final String date;
  final String time;
  final int distance;

  ConfirmDialog(
      {@required this.rentBloc,
      this.carName,
      this.source,
      this.destination,
      this.price,
      this.date,
      this.time,
      this.distance});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocListener<RentBloc, RentState>(
          cubit: rentBloc,
          listener: (context, rentState) {
            if (rentState is RentExceptionState) {
              String message;
              message = rentState.message;

              print('Error : $message');
            }
          },
          child: BlocBuilder<RentBloc, RentState>(
            cubit: rentBloc,
            builder: (context, state) => getViewAsPerState(state, context),
          )),
    );
  }

  getViewAsPerState(RentState state, BuildContext context) {
    print('STATE: $state');
    if (state is InitialRentState) {
      return _dialogContent(context);
    } else if (state is LoadingState) {
      return _loadingIndicator();
    } else if (state is RentRequestedState) {
      return _confirmedContent(context);
    } else if (state is RentNoInternetState) {
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
            carName,
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
                text: 'Do you want to confirm the request to rent ',
                style: TextStyle(
                    color: Colors.black, fontFamily: "Poppins-Medium"),
                children: <TextSpan>[
                  TextSpan(
                      text: '$carName',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: ' on'),
                  TextSpan(
                      text: ' $date $time ',
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
                    rentBloc.add(
                      SendRequestEvent(
                        carName,
                        source,
                        destination,
                        date,
                        time,
                        price,
                        distance,
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
                      'Request',
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
