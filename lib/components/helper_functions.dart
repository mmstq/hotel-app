import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/room.dart';

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

bool isStaff = false;

Future<void> checkIfStaff()async{
  final email = FirebaseAuth.instance.currentUser?.email;
  final user = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
  isStaff = user.docs.first.get('isStaff') as bool;
  Logger().d(isStaff);
}

Room? roomAsArgument;