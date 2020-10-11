import 'package:flutter/material.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class BuyCarDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: SizeConfig.blockSizeVertical*65,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeConfig.blockSizeHorizontal * 5,
              SizeConfig.blockSizeVertical * 5,
              SizeConfig.blockSizeHorizontal * 5,
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
                'Preferred Model',
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
                'Preferred Engine Variant',
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
                'Year Of Origin Range',
              ),
              TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
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
              Center(
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
            ],
          ),
        ),
      ),
    );
  }
}
