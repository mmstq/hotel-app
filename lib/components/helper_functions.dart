import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isTablet() {
  // Getting the MediaQuery data from the context
  final mediaQuery = MediaQuery.of(Get.context!);

  // The diagonal size of the screen in inches
  final double diagonalInches = _calculateDiagonalInches(mediaQuery);

  // Tablets typically have screens larger than 7 inches
  return diagonalInches >= 7.0;
}

double _calculateDiagonalInches(MediaQueryData mediaQuery) {
  final double widthInches = mediaQuery.size.width / mediaQuery.devicePixelRatio;
  final double heightInches = mediaQuery.size.height / mediaQuery.devicePixelRatio;

  // Calculating the diagonal size using Pythagoras' theorem
  return sqrt(widthInches * widthInches + heightInches * heightInches); // Using sqrt from dart:math
}