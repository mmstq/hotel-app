import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/custom_input_widgets.dart';
import 'package:hotel_app/components/input_button.dart';
import 'package:hotel_app/screens/sign_up.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome back!",
                  style: Get.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your luxurious room is waiting for you",
                  style: Get.textTheme.bodySmall!
                      .copyWith(color: Colors.grey.shade700, fontSize: 14),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please enter all your details",
                  style: Get.textTheme.bodySmall!
                      .copyWith(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),

              // Email Input Field
              TextInputField(
                label: 'Email',
                controller: authController.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Check if email format is valid
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password Input Field
              TextInputField(
                label: 'Password',
                controller: authController.passwordController,
                obscureText: false, // Hide the password text
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Login Button
              InputButton(
                onPressed: () => authController.loginUser(
                  authController.emailController.text.trim(),
                  authController.passwordController.text.trim(),
                ),
                label: 'Sign In',
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blueAccent.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
