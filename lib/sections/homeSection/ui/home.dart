import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/carBuySellSection/ui/car_buy_sell_screen.dart';
import 'package:morgadi/sections/carMortgageSection/ui/car_mortgage_screen.dart';
import 'package:morgadi/sections/carRentSection/ui/rent_screen.dart';
import 'package:morgadi/sections/carRepairSection/ui/car_repair_screen.dart';
import 'package:morgadi/sections/homeSection/model/morgadi_services.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MorgadiServices> morgadiServices = List<MorgadiServices>();

  @override
  void initState() {
    addServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Material(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: _serviceWidgets(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _serviceWidgets() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 3,
          vertical: SizeConfig.blockSizeVertical * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig.blockSizeHorizontal * 5),
          ),
          Column(
            children: List.generate(
              morgadiServices.length,
              (index) => singleService(
                morgadiServices[index],
                widgetTransition(index),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget singleService(
      MorgadiServices morgadiServices, Widget transitionWidget) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => transitionWidget));
      },
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeHorizontal,
            bottom: SizeConfig.blockSizeHorizontal),
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    morgadiServices.service,
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
            ),
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 20,
                width: SizeConfig.blockSizeHorizontal * 50,
                child: Hero(
                  tag: morgadiServices.service,
                  child: SvgPicture.asset(
                    morgadiServices.image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addServices() {
    for (int i = 0; i < 5; i++) {
      morgadiServices.add(MorgadiServices(serviceNames[i], serviceImages[i]));
    }
  }

  Widget widgetTransition(int index) {
    if (index == 0) {
      return CarRentScreen();
    } else if (index == 1) {
      return CarBuySellScreen();
    } else if (index == 2) {
      return CarRepairScreen();
    } else if (index == 3) {
      return CarMortgageScreen();
    } else {
      return Container(
        color: Colors.white,
        child: Image.asset("images/tata_indica.png", ),
      );
    }
  }
}
