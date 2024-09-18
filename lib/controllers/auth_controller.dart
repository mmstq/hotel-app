import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isAuthenticated = false.obs;
  final AuthService _authService = AuthService();

  // Function to handle login and Firebase Authentication
  Future<void> loginUser(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password must not be empty',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // If successful, navigate to the dashboard screen
      Get.offAllNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'No user found for that email.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Wrong password provided.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error',
          'The email address is not valid.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Login failed: ${e.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle general errors
      Get.snackbar(
        'Error',
        'An unknown error occurred.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Method for registration
  Future<void> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and password must not be empty',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      // Register user using Firebase Authentication
      User? user = await _authService.registerWithEmail(email, password);

      // Check if registration was successful
      if (user != null) {
        isAuthenticated.value = true;
        Get.offAllNamed('/dashboard');  // Navigate to dashboard after successful registration
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Registration Error',
          'The email address is already in use by another account.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Registration Error',
          'The email address is not valid.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          'Registration Error',
          'The password is too weak. Please choose a stronger password.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Registration Error',
          'Registration failed: ${e.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle general errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again later.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }


  // Function to log out the user
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      Get.offAllNamed(
          '/login'); // Navigate back to the login screen and clear navigation stack
    } catch (e) {
      Get.snackbar(
        'Logout Error',
        'Failed to log out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }
}
