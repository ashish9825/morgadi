import 'package:flutter/material.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class SellCar extends StatelessWidget {
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
            cursorColor: Colors.black,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: 'Honda Creta',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Model',
          ),
          TextFormField(
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
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Engine Variant',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
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
            'Registration Number',
          ),
          TextFormField(
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
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Text(
            'Year Of Origin',
          ),
          TextFormField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              hintText: '2017',
              hintStyle: TextStyle(color: Colors.grey[500]),
              fillColor: Colors.grey[200],
            ),
          ),
            SizedBox(
            height: SizeConfig.blockSizeVertical * 10,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4,
                  vertical: SizeConfig.blockSizeVertical*2),
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
        ],
      ),
    );
  }
}
