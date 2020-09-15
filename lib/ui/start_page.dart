import 'package:flutter/material.dart';
import 'package:morgadi/paints/circle_painter.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: <Widget>[
              // Circle(center: {"x": 100, "y": 400}, radius: 60, strokeWidth: 15),
              //Circle(center: {"x": 180, "y": 600}, radius: 28, strokeWidth: 15),
              Circle(center: {"x": 150, "y": 180}, radius: 40, strokeWidth: 15),
              //Circle(center: {"x": 200, "y": 400}, radius: 35, strokeWidth: 15),
              Circle(center: {"x": 80, "y": 190}, radius: 18, strokeWidth: 15),
              Circle(center: {"x": 200, "y": 120}, radius: 20, strokeWidth: 15),

              Circle(center: {"x": 00, "y": 120}, radius: 20, strokeWidth: 15),

              Circle(center: {"x": 300, "y": 240}, radius: 36, strokeWidth: 15),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: Image.asset(
            'images/start_screen.jpg',
          ),
        ),
      ],
    );
  }
}
