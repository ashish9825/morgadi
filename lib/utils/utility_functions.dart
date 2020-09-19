import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UtilityFunction {
  Widget loadingIndicator(double size, double borderWidth, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRipple(
            color: color,
            size: size,
            borderWidth: borderWidth,
          ),
        ],
      ),
    );
  }
}
