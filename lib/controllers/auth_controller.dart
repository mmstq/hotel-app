import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxString userType = 'Guest'.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

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

  // Function to handle login and Firebase Authentication
  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading.value = false;
      Get.offAllNamed('/guestDashboard');
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unknown error occurred.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password, bool isGuest) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Now we create a Firestore document for the user with currentUser.uid
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          'email': currentUser.email, // Email from Firebase Authentication
          'name': nameController.text, // Email from Firebase Authentication
          'isStaff': userType.value=='Staff', // Role passed during registration
        });
        isLoading.value = false;
        Get.offAllNamed('/login');
        Get.snackbar('Success',
            'Your account is created successfully. You can login now',
            snackPosition: SnackPosition.TOP, colorText: Colors.green);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Registration failed: ${e.message}');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  // Function to log out the user
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
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
