import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morgadi/sections/carRepairSection/bloc/repair_bloc.dart';
import 'package:morgadi/sections/carRepairSection/data/repair_repository.dart';
import 'package:morgadi/sections/carRepairSection/widgets/car_brand_dialog.dart';
import 'package:morgadi/sections/carRepairSection/widgets/car_model_dialog.dart';
import 'package:morgadi/sections/carRepairSection/widgets/repair_dialog.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/disabled_focus_node.dart';
import 'package:morgadi/utils/size_config.dart';

class CarRepairScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RepairBloc(
        repairRepository: RepairRepository(),
      ),
      child: CarRepair(),
    );
  }
}

class CarRepair extends StatefulWidget {
  @override
  _CarRepairState createState() => _CarRepairState();
}

class _CarRepairState extends State<CarRepair> {
  TextEditingController _carBrandController = TextEditingController();
  TextEditingController _carModelController = TextEditingController();
  TextEditingController _otherCarController = TextEditingController(text: " ");
  TextEditingController _problemController = TextEditingController();
  TextEditingController _variantController = TextEditingController();
  TextEditingController _regNoControlller = TextEditingController();

  bool otherCarVisible = false;

  RepairBloc _repairBloc;

  @override
  void initState() {
    _repairBloc = BlocProvider.of<RepairBloc>(context);
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
      body: _repairBody(),
    );
  }

  Widget _repairBody() {
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
                  'Repairing',
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
                  tag: 'Repairing',
                  child: SvgPicture.asset(
                    "images/car_repair.svg",
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
                    'Car Brand',
                  ),
                  TextFormField(
                    controller: _carBrandController,
                    focusNode: AlwaysDisabledFocusNode(),
                    enableInteractiveSelection: false,
                    onTap: () {
                      var brandSelected = showDialog(
                          context: context,
                          builder: (context) => CarBrandDialog());

                      brandSelected.then((value) => setState(() {
                            _carModelController.text = "";
                            otherCarVisible = false;
                            _carBrandController.text = value;
                          }));
                    },
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: 'Maruti Suzuki',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Text(
                    'Car Model',
                  ),
                  Builder(
                    builder: (context) => TextFormField(
                      controller: _carModelController,
                      focusNode: AlwaysDisabledFocusNode(),
                      enableInteractiveSelection: false,
                      onTap: () {
                        if (_carBrandController.text != "") {
                          var carModelSelected = showDialog(
                            context: context,
                            builder: (context) => CarModelDialog(
                              carBrand: _carBrandController.text,
                              repairBloc: _repairBloc,
                            ),
                          );

                          carModelSelected.then(
                            (value) => setState(() {
                              _carModelController.text = value;
                              if (value == 'Other*') {
                                otherCarVisible = true;
                              } else {
                                otherCarVisible = false;
                              }
                            }),
                          );
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Please Select Car Brand !')));
                        }
                      },
                      cursorColor: Colors.black,
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 4),
                      decoration: numberTextDecoration.copyWith(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.4,
                            horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                        hintText: 'Vitara Brezza',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: otherCarVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        Text(
                          'Other Car Model',
                        ),
                        TextFormField(
                          controller: _otherCarController,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4),
                          decoration: numberTextDecoration.copyWith(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 1.4,
                                horizontal:
                                    SizeConfig.safeBlockHorizontal * 2.8),
                            hintText: 'Any Known Model',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Text(
                    'Problem',
                  ),
                  TextFormField(
                    controller: _problemController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: 'Spark Plug Related Issue',
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
                    controller: _regNoControlller,
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
          if (_carBrandController.text != "" &&
              _carModelController.text != "" &&
              _otherCarController.text != "" &&
              _problemController.text != "" &&
              _variantController.text != "" &&
              _regNoControlller.text != "") {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: RepairDialog(
                  repairBloc: _repairBloc,
                  carBrand: _carBrandController.text,
                  carModel: _carModelController.text,
                  otherCar: _otherCarController.text,
                  problem: _problemController.text,
                  variant: _variantController.text,
                  regNo: _regNoControlller.text,
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
}
