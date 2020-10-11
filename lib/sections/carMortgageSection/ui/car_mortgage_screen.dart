import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class CarMortgageScreen extends StatefulWidget {
  @override
  _CarMortgageScreenState createState() => _CarMortgageScreenState();
}

class _CarMortgageScreenState extends State<CarMortgageScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _mortgageBody(),
    );
  }

  Widget _mortgageBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 8,
          right: SizeConfig.blockSizeHorizontal * 8,
          top: SizeConfig.blockSizeVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mortgage Service',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
                ),
                Container(
                  color: Color(0xFFFF7F98),
                  height: SizeConfig.blockSizeHorizontal,
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Center(
              child: Container(
                height: SizeConfig.blockSizeVertical * 25,
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Hero(
                  tag: 'Mortgage Service',
                  child: SvgPicture.asset(
                    "images/car_mortgage.svg",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.blockSizeHorizontal * 0,
                  SizeConfig.blockSizeVertical * 5,
                  SizeConfig.blockSizeHorizontal * 0,
                  0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount Needed',
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: '60000',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                      prefixIcon: SizedBox(
                        width: SizeConfig.blockSizeHorizontal,
                        child: Center(
                          child: Text(
                            '₹',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal * 4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Text(
                    'Car',
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
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
                    'Engine Variant',
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: 'Diesel',
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
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
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
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
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
                    height: SizeConfig.blockSizeVertical * 5,
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
                        'Request',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
