import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:logger/logger.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String role = '';
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          bool isGuest =
              userDoc['role'] as bool; // Assume role is stored as bool
          setState(() {
            role = isGuest ? 'Guest' : 'Staff'; // Map boolean to string
            _emailController.text = currentUser.email ?? '';
          });
        }
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
      setState(() {
        isLoading = false;
      });
    }
  }

  // Handle form submission and update user data in Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // Start loading
      });

      try {
        // Get the current user
        User? currentUser = _auth.currentUser;

        if (currentUser != null) {
          // Update the email in Firebase Authentication
          await currentUser
              .verifyBeforeUpdateEmail(_emailController.text.trim());

          // Update the user profile in Firestore (excluding role, as it is not editable)
          await _firestore.collection('users').doc(currentUser.uid).update({
            'email': _emailController.text.trim(),
          });

          Get.snackbar(
            'Success',
            'Profile updated successfully',
            snackPosition: SnackPosition.TOP,
          );
        }
      } on FirebaseAuthException catch (e) {
        _logger.e("Error fetching user profile: $e");
        Get.snackbar(
          'Error',
          'Failed to update profile: ${e.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      role,
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _emailController,
                      label: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputButton(
                      onPressed: _submitForm,
                      label: const Text(
                        'Update Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
