import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:morgadi/sections/carRentSection/bloc/rent.dart';
import 'package:morgadi/sections/carRentSection/data/firestore_provider.dart';
import 'package:morgadi/sections/carRentSection/data/rent_repository.dart';
import 'package:morgadi/sections/carRentSection/model/car.dart';
import 'package:morgadi/sections/carRentSection/widgets/car_item_select.dart';
import 'package:morgadi/sections/carRentSection/widgets/confirm_dialog.dart';
import 'package:morgadi/utils/size_config.dart';

class CarOptions extends StatelessWidget {
  final String source;
  final String destination;
  final String date;
  final String time;

  CarOptions({Key key, this.source, this.destination, this.date, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RentBloc>(
      create: (context) => RentBloc(rentRepository: RentRepository()),
      child: SelectCar(
        source: source,
        destination: destination,
        date: date,
        time: time,
      ),
    );
  }
}

class SelectCar extends StatefulWidget {
  SelectCar(
      {this.rentRepository,
      this.source,
      this.destination,
      this.date,
      this.time});

  final RentRepository rentRepository;
  final String source;
  final String destination;
  final String date;
  final String time;

  @override
  _SelectCarState createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  FirestoreProvider _provider = FirestoreProvider();
  RentBloc _rentBloc;

  @override
  void initState() {
    _rentBloc = BlocProvider.of<RentBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFFAFAFA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: selectCar(),
    );
  }

  Widget selectCar() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 5,
        right: SizeConfig.blockSizeHorizontal * 5,
        top: SizeConfig.blockSizeVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select A Car',
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
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
          Expanded(
            child: _carsBody(),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
        ],
      ),
    );
  }

  Widget _carsBody() {
    return widget(
          child: StreamBuilder<QuerySnapshot>(
        stream: _provider.fetchCars(widget.source, widget.destination),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Car car = Car.fromSnapshot(snapshot.data.docs[index]);
                return InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => WillPopScope(
                        onWillPop: () async => false,
                        child: ConfirmDialog(
                          rentBloc: _rentBloc,
                          source: widget.source,
                          destination: widget.destination,
                          carName: car.name,
                          price: _provider.priceForRent(
                              widget.source, widget.destination, car.name),
                          date: widget.date,
                          time: widget.time,
                          distance: _provider.distanceInKm(
                              widget.source, widget.destination),
                        ),
                      ),
                    );
                  },
                  child: CarItemSelect(
                    car: car,
                    price: _provider.priceForRent(
                        widget.source, widget.destination, car.name),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return _errorWidget(snapshot.error);
          } else {
            return _loadingIndicator();
          }
        },
      ),
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

  @override
  void dispose() {
    _rentBloc.close();
    super.dispose();
  }
}
