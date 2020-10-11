import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/carRentSection/data/firestore_provider.dart';
import 'package:morgadi/sections/carRentSection/widgets/city_options_dialog.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/disabled_focus_node.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:intl/intl.dart';

class CarRentScreen extends StatefulWidget {
  @override
  _CarRentScreenState createState() => _CarRentScreenState();
}

class _CarRentScreenState extends State<CarRentScreen> {
  TextEditingController _sourceController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> destinations = [];

  FirestoreProvider _provider = FirestoreProvider();

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
      body: _rentBody(),
    );
  }

  Widget _rentBody() {
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
                  'Rent A Car',
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
                  tag: 'Rent A Car',
                  child: SvgPicture.asset(
                    "images/car_rent.svg",
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
                    'Select Source',
                  ),
                  TextFormField(
                    controller: _sourceController,
                    focusNode: AlwaysDisabledFocusNode(),
                    enableInteractiveSelection: false,
                    onTap: () {
                      print(cityOptions);
                      var sourceSelected = showDialog(
                        context: context,
                        builder: (context) => CityOptionsDialog(
                            cities: cityOptions, title: 'Select Source'),
                      );

                      sourceSelected.then(
                        (value) => setState(() {
                          if (_destinationController.text == value) {
                            _destinationController.clear();
                          }
                          _sourceController.text = value;
                        }),
                      );
                    },
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: 'Source',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Text(
                    'Select Destination',
                  ),
                  TextFormField(
                    controller: _destinationController,
                    focusNode: AlwaysDisabledFocusNode(),
                    enableInteractiveSelection: false,
                    onTap: () async {
                      if (_sourceController.text != null &&
                          _sourceController.text != '') {
                        await addDestinations();

                        destinations.remove(_sourceController.text);

                        var destinationSelected = showDialog(
                          context: context,
                          builder: (context) => CityOptionsDialog(
                            cities: destinations,
                            title: 'Select Destination',
                          ),
                        );

                        destinationSelected.then(
                          (value) => setState(() {
                            _destinationController.text = value;
                          }),
                        );
                      }
                    },
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: 'Destination',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Text(
                    'Date of Boarding',
                  ),
                  TextFormField(
                    controller: _dateController,
                    focusNode: AlwaysDisabledFocusNode(),
                    enableInteractiveSelection: false,
                    onTap: () {
                      var bookingDate = _selectDate();

                      bookingDate.then(
                        (value) => setState(() {
                          if (value != "") {
                            _dateController.text = value;
                          }
                        }),
                      );
                    },
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: '01-01-2019',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Text(
                    'Time of Boarding',
                  ),
                  TextFormField(
                    controller: _timeController,
                    focusNode: AlwaysDisabledFocusNode(),
                    enableInteractiveSelection: false,
                    onTap: () {
                      var bookingTime = _selectTime();

                      bookingTime.then(
                        (value) => setState(() {
                          if (value != "") {
                            _timeController.text = value;
                          }
                        }),
                      );
                    },
                    cursorColor: Colors.black,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                    decoration: numberTextDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.4,
                          horizontal: SizeConfig.safeBlockHorizontal * 2.8),
                      hintText: '08:00 AM',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  InkWell(
                    onTap: () async {
                      _provider
                          .carsAvailable(_sourceController.text,
                              _destinationController.text)
                          .then((value) {
                        print('List $value');
                      });
                    },
                    child: Center(
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
                          'Search For Cars',
                          style: TextStyle(color: Colors.white),
                        ),
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

  Future<void> addDestinations() {
    destinations.clear();
    for (int i = 0; i < cityOptions.length; i++) {
      destinations.add(cityOptions[i]);
    }
    return null;
  }

  _selectDate() async {
    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, 12, 31),
        helpText: 'Select Booking Date',
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.yellow,
              ),
            ),
            child: child,
          );
        });

    String formattedDate = "";

    if (_picked != null) {
      setState(() {
        selectedDate = _picked;
        formattedDate = '${DateFormat('d-MM-yyyy').format(selectedDate)}';
      });
    }
    return formattedDate;
  }

  _selectTime() async {
    final TimeOfDay _timePicked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        helpText: 'Select Booking Time',
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.yellow,
              ),
            ),
            child: child,
          );
        });

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = "";

    if (_timePicked != null) {
      setState(() {
        selectedTime = _timePicked;
        formattedTime = localizations.formatTimeOfDay(selectedTime,
            alwaysUse24HourFormat: false);
      });
    }

    return formattedTime;
  }

  double toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;
}
