import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:hotel_app/controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Obx(()=>Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                controller.role,
                style: Get.theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,fontSize: 50,
                ),
              ),
              const SizedBox(height: 20),
              TextInputField(
                label: 'Name',
                prefixIcon: const Icon(Icons.title),
                controller: controller.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextInputField(
                enabled: false,
                prefixIcon: const Icon(Icons.alternate_email_sharp),

                controller: controller.emailController,
                label: 'Email',
              ),
              const SizedBox(height: 20),
              InputButton(
                onPressed: controller.submitForm,
                label: const Text(
                  'Update Profile',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
