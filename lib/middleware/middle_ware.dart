import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is authenticated
    bool noUser = FirebaseAuth.instance.currentUser == null;

    if (noUser) {
      // Redirect to login page if not authenticated
      return  const RouteSettings(name: '/login');
    }

    // Allow access to the requested route if authenticated
    return null;
  }
}