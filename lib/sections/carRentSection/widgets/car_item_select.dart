import 'package:flutter/material.dart';
import 'package:morgadi/sections/carRentSection/model/car.dart';
import 'package:morgadi/utils/size_config.dart';

class CarItemSelect extends StatelessWidget {
  final Car car;
  final String source;
  final String destination;
  final String price;
  CarItemSelect({this.car, this.source, this.destination, this.price});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1.5),
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 3,
            vertical: SizeConfig.blockSizeVertical * 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              car.image,
              height: SizeConfig.blockSizeVertical * 6,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  car.name,
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4,color: Color(0xFFc8a104)),
                ),
                Text('₹ $price'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
