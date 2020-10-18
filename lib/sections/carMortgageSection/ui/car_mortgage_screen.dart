import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/carMortgageSection/bloc/mortgage.dart';
import 'package:morgadi/sections/carMortgageSection/data/mortgage_repository.dart';
import 'package:morgadi/sections/carMortgageSection/widgets/mortgage_dialog.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class CarMortgageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MortgageBloc>(
      create: (context) =>
          MortgageBloc(mortgageRepository: MortgageRepository()),
      child: CarMortgage(),
    );
  }
}

class CarMortgage extends StatefulWidget {
  @override
  _CarMortgageState createState() => _CarMortgageState();
}

class _CarMortgageState extends State<CarMortgage> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _carController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _variantController = TextEditingController();
  TextEditingController _regNoController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  MortgageBloc _mortgageBloc;

  @override
  void initState() {
    _mortgageBloc = BlocProvider.of<MortgageBloc>(context);
    super.initState();
  }

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
                    controller: _amountController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
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
                    'Model',
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
                    'Engine Variant',
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
                    controller: _regNoController,
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
                    controller: _yearController,
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
                  _confirmButton(),
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

  Widget _confirmButton() {
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          if (_amountController.text != "" &&
              _carController.text != "" &&
              _modelController.text != "" &&
              _variantController.text != "" &&
              _regNoController.text != "" &&
              _yearController.text != "") {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: MortgageDialog(
                  mortgageBloc: _mortgageBloc,
                  amount: _amountController.text,
                  car: _carController.text,
                  model: _modelController.text,
                  variant: _variantController.text,
                  regNo: _regNoController.text,
                  originYear: _yearController.text,
                ),
              ),
            );
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
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
              ),
            );
          }
        },
        child: Center(
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
              'Request',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mortgageBloc.close();
    super.dispose();
  }
}
