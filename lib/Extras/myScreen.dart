import 'package:flutter/material.dart';

class MyScreen {
  static var height;
  static var width;

  static double getScreenHeight(BuildContext context) {
    height ??= MediaQuery.of(context).size.height;
    return height;
  }

  static double getScreenWidth(BuildContext context) {
    width ??= MediaQuery.of(context).size.width;
    return width;
  }
}
