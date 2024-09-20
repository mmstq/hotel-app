import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  String role = '';
  User? user;
  final Logger logger = Logger();

  // Clear text fields whenever the controller is initialized or when needed
  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    loadUserProfile();
    super.onInit();
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

  // Handle form submission and update user data in Firestore
  Future<void> loadUserProfile() async {
    isLoading.value = true;
    try {
      DocumentSnapshot userDoc = await firestore.collection('users').doc(user!.uid).get();
      if (userDoc.exists) {
        role = userDoc['isStaff'] as bool ? 'Staff' : 'Guest'; // Map boolean to string
        emailController.text = user!.email ?? '';
        nameController.text = userDoc['name'] ?? '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user profile: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Handle form submission and update user data in Firestore
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true; // Start loading

      try {
        // Update the user profile in Firestore (excluding role, as it is not editable)
        await firestore.collection('users').doc(user!.uid).update({
          'name': nameController.text,
        });

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.TOP,
        );
      } on FirebaseAuthException catch (e) {
        logger.e("Error fetching user profile: $e");
        Get.snackbar(
          'Error',
          'Failed to update profile: ${e.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false; // Stop loading
      }
    }
  }
}
