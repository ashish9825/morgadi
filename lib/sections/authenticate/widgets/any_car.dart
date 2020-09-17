import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/authenticate/model/any_car_item.dart';
import 'package:morgadi/utils/size_config.dart';

class AnyCar extends StatelessWidget {
  final AnyCarItem _item;
  AnyCar(this._item);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        color: _item.isSelected ? _item.color : Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 3,
            vertical: SizeConfig.blockSizeVertical * 0.3),
        child: Row(
          children: [
            SvgPicture.asset(
              _item.assetImage,
              height: SizeConfig.blockSizeVertical * 1.75,
              color: _item.isSelected ? _item.assetColor : Colors.black,
            ),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 2,
            ),
            Text(_item.buttonText),
          ],
        ),
      ),
    );
  }
}
