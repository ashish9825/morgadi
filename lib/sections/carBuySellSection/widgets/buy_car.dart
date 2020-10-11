import 'package:flutter/material.dart';
import 'package:morgadi/sections/carBuySellSection/widgets/buy_car_dialog.dart';
import 'package:morgadi/utils/size_config.dart';

class BuyCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(color: Colors.transparent,),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BuyCarDialog();
                  });
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2,
                  horizontal: SizeConfig.blockSizeHorizontal * 4),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 2,
                  vertical: SizeConfig.blockSizeVertical),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
              ),
              child: Text(
                'Any Different Car ?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget carDetails() {}
}
