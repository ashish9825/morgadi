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

Map<String, dynamic> perKmCharges = {
  'Maruti Suzuki Ertiga': 16,
  'Maruti Suzuki Swift': 14,
  'Tata Indica': 13,
  'Toyota Innova': 21,
};

Map<String, dynamic> convCharges = {
  'Maruti Suzuki Ertiga': 400,
  'Maruti Suzuki Swift': 300,
  'Tata Indica': 200,
  'Toyota Innova': 500,
};

Map<String, dynamic> bilaspur = {
  'Champa': 56,
  'Korba': 90,
  'Raigarh': 150,
  'Raipur': 118,
};

Map<String, dynamic> champa = {
  'Bilaspur': 56,
  'Korba': 50,
  'Raigarh': 100,
  'Raipur': 170,
};

Map<String, dynamic> korba = {
  'Bilaspur': 90,
  'Champa': 50,
  'Raigarh': 110,
  'Raipur': 212,
};

Map<String, dynamic> raigarh = {
  'Bilaspur': 150,
  'Champa': 100,
  'Korba': 110,
  'Raipur': 256,
};

Map<String, dynamic> raipur = {
  'Bilaspur': 118,
  'Champa': 170,
  'Korba': 212,
  'Raigarh': 256,
};

List carBrands = [
  'Ford',
  'Honda',
  'Hyundai',
  'Kia',
  'Mahindra',
  'Maruti Suzuki',
  'Nissan',
  'Renault',
  'Tata',
  'Toyota',
];

List ford = [
  'Aspire',
  'Figo',
  'Freestyle',
  'EcoSport',
  'Endeavour',
];

List honda = [
  'Amaze',
  'BR-V',
  'City',
  'Civic',
  'CR-V',
  'Jazz',
  'WR-V',
];  
