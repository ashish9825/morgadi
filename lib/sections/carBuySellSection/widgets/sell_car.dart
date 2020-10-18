import 'package:flutter/material.dart';
import 'package:morgadi/sections/carBuySellSection/bloc/buy_sell.dart';
import 'package:morgadi/sections/carBuySellSection/widgets/sell_confirm_dialog.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class SellCar extends StatefulWidget {
  SellCar(this.buySellBloc);

  final BuySellBloc buySellBloc;

  @override
  _SellCarState createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {

  String car, model, variant, regNo, year = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: carForm(),
    );
  }

  Widget carForm() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal * 10,
          SizeConfig.blockSizeVertical * 5,
          SizeConfig.blockSizeHorizontal * 10,
          0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Car',
          ),
          TextFormField(
            // controller: _carController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'Hyundai Creta',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
            ),
            onChanged: (value) {
              car = value;
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Model',
          ),
          TextFormField(
            // controller: _modelController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'SX Turbo 7 DCT',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
            ),
            onChanged: (value) {
              model = value;
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Engine Variant',
          ),
          TextFormField(
            // controller: _variantController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'Petrol',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
            ),
            onChanged: (value) {
              variant = value;
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Registration Number',
          ),
          TextFormField(
            // controller: _regNoController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'CG 04 FA 5866',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
            ),
            onChanged: (value) {
              regNo = value;
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Year Of Origin',
          ),
          TextFormField(
            // controller: _yearController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            maxLength: 4,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: '2017',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
              counter: Container(),
            ),
            onChanged: (value) {
              year = value;
            },
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 10,
          ),
          Center(
            child: registerButton(),
          ),
        ],
      ),
    );
  }

  Widget registerButton() {

    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          if (car != "" &&
              model != "" &&
              variant != "" &&
              regNo != "" &&
              year != "" &&
              year.length == 4) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: SellConfirmDialoog(
                  buySellBloc: widget.buySellBloc,
                  car: car,
                  model: model,
                  variant: variant,
                  regNo: regNo,
                  year: year,
                ),
              ),
            );
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Please fill in all the details !',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red[300],
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 4,
              vertical: SizeConfig.blockSizeVertical * 2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
          ),
          child: Text(
            'Register To Sell',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
