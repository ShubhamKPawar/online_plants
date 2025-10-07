library;

import 'package:flutter/material.dart';

abstract class SizeConfig {
  const SizeConfig._();

  //device orientation
  static late Orientation orientation;

  //text scale factor
  static late double scaleFactor;

  //device width
  static late double deviceWidth;

  //device height
  static late double devideHeigth;

  //device aspect ratio width/height
  static late double aspectRatio;

  //to current current device is mobile or not
  static late bool isMobile;

  //static get orientation is landscape
  static get isLandscape => orientation == Orientation.landscape;

  //Set all variable values
  static void setSizeConfig(BuildContext context) {
    //Get current device orientation
    orientation = MediaQuery.of(context).orientation;

    //Get current device width
    deviceWidth = MediaQuery.of(context).size.width;

    //Get current device height
    devideHeigth = MediaQuery.of(context).size.height;

    //Get current devie aspect ratio
    aspectRatio = MediaQuery.of(context).size.aspectRatio;

    //Check if current device is mobile or not
    isMobile = MediaQuery.of(context).size.shortestSide < 600;

    //Get current device text scale factor fontSize:14 is set and devided by 14 to get current scale factor
    double currentScale = MediaQuery.of(context).textScaler.scale(14.0) / 14.0;

    /*If currentScale if < or = 1 then make scale factor as 1 (i.e min scale factor is 1)
      else if currentScale if > or = 1.5 then make scale factor as 1.5 (i.e max scale factor is 1.5)
      else assign currentScale value to scaleFactor
    */
    if (currentScale <= 1.0) {
      scaleFactor = 1.0;
    } else if (currentScale >= 1.2) {
      scaleFactor = 1.2;
    } else {
      scaleFactor = currentScale;
    }
  }

  //Get Size Config Map
  static Map<String, dynamic> getSizeConfig() {
    return {
      'deviceWidth': deviceWidth,
      'devideHeigth': devideHeigth,
      'aspectRatio': aspectRatio,
      'isMobile': isMobile,
      'scaleFactor': scaleFactor,
      'orientation': orientation
    };
  }
}

// double scaleFromString(String input) {
//   if (input == "no scaling") {
//     return 1.0;
//   }
//   final RegExp regExp = RegExp(r'(\d+(\.\d+)?)x');
//   final match = regExp.firstMatch(input);

//   if (match != null) {
//     return double.parse(match.group(1)!);
//   }
//   return 1.0;
// }
