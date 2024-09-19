import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;


  // Clear text fields whenever the controller is initialized or when needed
  @override
  void onInit() {
    super.onInit();
    clearFields();
  }

  // Clear text fields whenever this is called
  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  // Show loading dialog
  void showLoadingDialog() {
    Get.dialog(
      const Center(
        child: CupertinoActivityIndicator(
          radius: 20,
        ),
      ),
      barrierDismissible: false, // Prevent the user from closing the dialog
    );
  }

  // Hide loading dialog
  void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();  // Close the dialog
    }
  }

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

    // Show progress indicator while authenticating
    showLoadingDialog();

    try {
      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // If successful, navigate to the dashboard screen
      hideLoadingDialog();// Hide the loading dialog
      Get.offAllNamed(
          '/guestDashboard'); // Navigate to guestDashboard after successful login

    } on FirebaseAuthException catch (e) {
      hideLoadingDialog(); // Hide the loading dialog on error
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
      hideLoadingDialog();
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

    showLoadingDialog();  // Show progress indicator while registering
    try {
      // Register user using Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if registration was successful
      hideLoadingDialog();  // Hide the loading dialog on success
      Get.offAllNamed(
          '/guestDashboard'); // Navigate to guestDashboard after successful registration
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog();  // Hide the loading dialog on error
      // Handle FirebaseAuth errors
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'The email address is already in use by another account.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error',
          'The email address is not valid.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'The password is too weak. Please choose a stronger password.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Registration failed: ${e.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      hideLoadingDialog();
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
    showLoadingDialog();  // Show progress indicator while logout
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      hideLoadingDialog();  // Hide the loading dialog on success
      Get.offAllNamed(
          '/login'); // Navigate back to the login screen and clear navigation stack
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to log out. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }
}
