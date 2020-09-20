import 'package:flutter/material.dart';
import 'package:morgadi/sections/authenticate/model/any_car_item.dart';

const themeColor = Color(0xFFFDD32A);

const numberTextDecoration = InputDecoration(
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEEEEEE)),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEEEEEE)),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

List<AnyCarItem> yesOrNo = [
  AnyCarItem(
      true, 'Yes', Colors.grey[200], "images/yes.svg", Color(0xFFc8a104)),
  AnyCarItem(false, 'No', Colors.grey[200], "images/no.svg", Color(0xFFc8a104)),
];
