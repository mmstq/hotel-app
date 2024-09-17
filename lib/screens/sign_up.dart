import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/custom_input_widgets.dart';
import 'package:hotel_app/components/input_button.dart';
import '../controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome!",
                style: Get.textTheme.displaySmall!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w700),
              ),
            ),const SizedBox(height: 4),
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
            TextInputField(
              label: 'Email ',
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextInputField(
              label: 'Password',
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            InputButton(
              onPressed: () {
                authController.register(
                  emailController.text,
                  passwordController.text,
                );
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
    );
  }
}
