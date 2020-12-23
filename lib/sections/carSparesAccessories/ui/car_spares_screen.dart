import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/carSparesAccessories/widgets/car_brand_dialog.dart';
import 'package:morgadi/sections/carSparesAccessories/widgets/car_model_dialog.dart';
import 'package:morgadi/sections/carSparesAccessories/widgets/spares_dialog.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/disabled_focus_node.dart';
import 'package:morgadi/utils/size_config.dart';
import '../bloc/spares.dart';
import '../data/spares_repository.dart';

class CarSparesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SparesBloc(sparesRepository: SparesRepository()),
      child: CarSpares(),
    );
  }
}

class CarSpares extends StatefulWidget {
  @override
  _CarSparesState createState() => _CarSparesState();
}

class _CarSparesState extends State<CarSpares> {
  TextEditingController _partNameController = TextEditingController();
  TextEditingController _carController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _otherCarController = TextEditingController(text: " ");
  TextEditingController _variantController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  bool otherCarVisible = false;

  SparesBloc _sparesBloc;

  @override
  void initState() {
    _sparesBloc = BlocProvider.of<SparesBloc>(context);
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
      body: _sparesBody(),
    );
  }

  Widget _sparesBody() {
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
                  'Spares & Accessories',
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
                  tag: 'Spares & Accessories',
                  child: SvgPicture.asset(
                    "images/car_spare.svg",
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
                    'Part Name',
                  ),
                  TextFormField(
                    controller: _partNameController,
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: 'Spark Plug',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
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
                    focusNode: AlwaysDisabledFocusNode(),
                    enableInteractiveSelection: false,
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();

                      var brandSelected = showDialog(
                          context: context,
                          builder: (context) => CarBrandDialog());

                      brandSelected.then((value) => setState(() {
                            _modelController.text = "";
                            otherCarVisible = false;
                            _carController.text = value;
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
                    'Model',
                  ),
                  Builder(
                    builder: (context) => TextFormField(
                      controller: _modelController,
                      focusNode: AlwaysDisabledFocusNode(),
                      enableInteractiveSelection: false,
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        currentFocus.unfocus();

                        if (_carController.text != "") {
                          var carModelSelected = showDialog(
                            context: context,
                            builder: (context) => CarModelDialog(
                              carBrand: _carController.text,
                              sparesBloc: _sparesBloc,
                            ),
                          );

                          carModelSelected.then(
                            (value) => setState(() {
                              _modelController.text = value;
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
          if (_partNameController.text != "" &&
              _carController.text != "" &&
              _modelController.text != "" &&
              _otherCarController.text != "" &&
              _variantController.text != "" &&
              _yearController.text != "") {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: SparesDialog(
                  partName: _partNameController.text,
                  sparesBloc: _sparesBloc,
                  car: _carController.text,
                  model: _modelController.text,
                  otherCar: _otherCarController.text,
                  variant: _variantController.text,
                  originYear: _yearController.text,
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
