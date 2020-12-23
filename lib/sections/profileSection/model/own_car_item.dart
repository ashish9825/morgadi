import 'package:flutter/material.dart';

class OwnCarItem {
  bool isSelected;
  final String buttonText;
  final Color color;
  final String assetImage;
  final Color assetColor;

  OwnCarItem(this.isSelected, this.buttonText, this.color, this.assetImage,
      this.assetColor);
}
