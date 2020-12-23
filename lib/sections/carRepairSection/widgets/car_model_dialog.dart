import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/carRepairSection/bloc/repair.dart';
import 'package:morgadi/sections/carRepairSection/data/repair_provider.dart';
import 'package:morgadi/utils/size_config.dart';

class CarModelDialog extends StatelessWidget {
  final String carBrand;
  final RepairBloc repairBloc;
  CarModelDialog({@required this.carBrand, @required this.repairBloc});

  RepairProvider _provider = RepairProvider();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1.5,
          bottom: SizeConfig.blockSizeVertical * 1.5,
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              carBrand,
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
            Container(
              color: Color(0xFFFF7F98),
              height: SizeConfig.blockSizeHorizontal,
              width: SizeConfig.blockSizeHorizontal * 5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            _modelsBody(context),
          ],
        ),
      ),
    );
  }

  Widget _modelsBody(BuildContext context) {
    return StreamBuilder(
      stream: repairBloc.internetStream,
      builder: (ctxt, AsyncSnapshot<DataConnectionStatus> snap) {
        if (!snap.hasData) {
          return _loadingIndicator();
        }
        var result = snap.data;

        switch (result) {
          case DataConnectionStatus.disconnected:
            {
              return Center(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 40,
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Lottie.asset("assets/no_internet.json"),
                ),
              );
            }
          case DataConnectionStatus.connected:
            {
              return StreamBuilder<DocumentSnapshot>(
                stream: _provider.fetchCarModels(carBrand),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: List.generate(
                        snapshot.data.data()['cars'].length,
                        (index) => modelWidget(
                            snapshot.data.data()['cars'][index], context),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return _errorWidget(snapshot.error);
                  } else {
                    return _loadingIndicator();
                  }
                },
              );
            }
          default:
            {
              return Center(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 40,
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Lottie.asset("assets/no_internet.json"),
                ),
              );
            }
        }
      },
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRipple(
            color: Colors.black,
            size: SizeConfig.blockSizeHorizontal * 20,
            borderWidth: SizeConfig.blockSizeHorizontal * 3,
          ),
        ],
      ),
    );
  }

  Widget _errorWidget(String error) {
    return Text(error.toString());
  }

  modelWidget(String model, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, model);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(model),
            ],
          ),
        ),
      ),
    );
  }
}
