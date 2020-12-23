import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:morgadi/sections/authenticate/model/any_car_item.dart';
import 'package:morgadi/sections/profileSection/model/own_car_item.dart';

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

List<OwnCarItem> yesOrNoOptions = [
  OwnCarItem(
      true, 'Yes', Colors.grey[200], "images/yes.svg", Color(0xFFc8a104)),
  OwnCarItem(false, 'No', Colors.grey[200], "images/no.svg", Color(0xFFc8a104)),
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
  "Spares & Accessories"
];

List<String> cityOptions = ['Champa', 'Bilaspur', 'Korba', 'Raigarh', 'Raipur'];

Map<String, dynamic> perKmCharges = {
  'Maruti Suzuki Ertiga': 16,
  'Maruti Suzuki Swift': 14,
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

List profileOptionTexts = [
  'My Orders',
  'Edit Profile',
  'Help Desk',
  'Policies',
  'Share',
  'Rate Us',
];

List profileOptionIcons = [
  AntDesign.tagso,
  AntDesign.edit,
  AntDesign.smileo,
  AntDesign.profile,
  AntDesign.sharealt,
  AntDesign.staro,
];

List contactIcons = [
  AntDesign.mail,
  AntDesign.phone,
];

List contactTexts = [
  'Mail Us',
  'Call Us',
];

List contactSubTexts = [
  'Get quick resolution on queries related to Morgadi',
  'A quick call to Morgadi agent to help resolve your issue',
];

List policyIcons = [
  AntDesign.questioncircleo,
  AntDesign.profile,
  AntDesign.exclamationcircleo,
  AntDesign.filetext1
];

List policyTexts = [
  'About Mor Gadi',
  'Privacy Policy',
  'Terms & Conditions',
  'Open Source Licenses'
];