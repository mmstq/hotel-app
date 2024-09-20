import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:hotel_app/components/button.dart';
import '../controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  String userType = 'Guest';

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
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: CupertinoColors.inactiveGray.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: ['Staff', 'Guest']
                      .map((e) => Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                setState(() {
                                  userType = e;
                                });
                              },
                              child: AnimatedContainer(
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 300),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: userType == e
                                        ? Colors.blue
                                        : Colors.transparent),
                                child: Text(
                                  e,
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontWeight: userType == e
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: userType == e
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),

              // Email Input Field
              TextInputField(
                label: 'Email',
                prefixIcon: const Icon(Icons.alternate_email_outlined),
                controller: authController.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Obx(
                () => TextInputField(
                  obscureText: !authController.showPassword.value,
                  label: 'Password',
                  prefixIcon: const Icon(Icons.key_outlined),
                  controller: authController.passwordController,
                  suffixIcon: IconButton(
                    highlightColor: Colors.transparent,
                    splashRadius: null,
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
              InputButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      !authController.isLoading.value) {
                    authController.register(
                      authController.emailController.text.trim(),
                      authController.passwordController.text.trim(),
                      userType == 'Guest'
                    );
                  }
                },
                label: Obx(
                  () => authController.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 15,
                          ),
                        )
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
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
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.blue,
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
