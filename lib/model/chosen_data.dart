import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_new/constant/colors.dart';

class ChosenData extends ColorConstants {
  List<Color> chosenTilesColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  Color enter = Colors.white.withOpacity(0.4);

  colorChange(int index) {
    enter=enterColor;
    chosenTilesColors[index]=chosenColor;
  }
}
