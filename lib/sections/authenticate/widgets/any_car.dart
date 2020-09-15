import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/authenticate/model/any_car_item.dart';

class AnyCar extends StatelessWidget {
  final AnyCarItem _item;
  AnyCar(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              color: _item.isSelected ? _item.color : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    _item.assetImage,
                    height: 15.0,
                    color: _item.isSelected ? _item.assetColor : Colors.black,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(_item.buttonText),
                ],
              ),
            ),
          
    );
  }
}
