import 'package:flutter/material.dart';

class Dimension extends ChangeNotifier {
  double _height = 0;
  double _width = 0;

  double get height => _height;
  double get width => _width;

  void setScreenSize(double height, double width) {
    _height = height;
    _width = width;
    notifyListeners();
  }
}
