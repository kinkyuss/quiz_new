import 'package:flutter/material.dart';

class DeviceSize {
  late double _height;
  late double _width;
  late double _textScaleFactor;

  DeviceSize(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _textScaleFactor = MediaQuery.of(context).textScaleFactor;
  }

  double get height => _height;

  double get width => _width;

  double get textScaleFactor => _textScaleFactor;
}
