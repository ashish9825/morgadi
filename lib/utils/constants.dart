import 'package:flutter/material.dart';

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
