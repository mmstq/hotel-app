import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:hotel_app/components/button.dart';
import '../controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>(); // Add form key for validation

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authController.clearFields();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey, // Wrap the entire form in a Form widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  style: Get.textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Let's create an account for you",
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Luxury rooms are waiting for you",
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
              const SizedBox(
                height: 10,
              ),

              // Email Input Field
              TextInputField(
                label: 'Email',
                prefixIcon: const Icon(CupertinoIcons.mail_solid),
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
              Obx(
                () => TextInputField(
                  obscureText: !authController.showPassword.value,
                  label: 'Password',
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  controller: authController.passwordController,
                  suffixIcon: IconButton(
                    highlightColor: Colors.transparent,
                    splashRadius:null,
                    splashColor: Colors.transparent,
                    padding: const EdgeInsets.all(0),
                    icon: authController.showPassword.value
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                    onPressed: () {
                      authController.showPassword.value =
                          !authController.showPassword.value;
                    },
                  ),
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
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              InputButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.register(
                      authController.emailController.text.trim(),
                      authController.passwordController.text.trim(),
                    );
                  }
                },
                label: 'Sign Up',
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    ),
                    child: Text(
                      'Sign In',
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
