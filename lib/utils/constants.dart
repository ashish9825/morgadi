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

List<String> serviceImages = [
  "images/car_rent.svg",
  "images/car_buy_sell.svg",
  "images/car_repair.svg",
  "images/car_mortgage.svg",
  "images/car_spare.svg"
];

List<String> serviceNames = [
  "Rent A Car",
  "Buy / Sell",
  "Repairing",
  "Mortgage Service",
  "Car Spares"
];

List<String> cityOptions = ['Champa', 'Bilaspur', 'Korba', 'Raigarh', 'Raipur'];

Map<String, dynamic> perKmCharge = {
  'Indica': 13,
  'Swift': 14,
  'Ertiga': 16,
  'Innova': 21,
};
