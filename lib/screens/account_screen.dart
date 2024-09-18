import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/screens/profile.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();

  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage, // Open image picker on tap
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: _image != null
                        ? FileImage(
                            File(_image!.path),
                          )
                        : const AssetImage('assets/room_icon.png')
                            as ImageProvider, // Placeholder image
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Profile'),
                  subtitle: const Text('Update your profile information'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                ),
                ListTile(
                  title: const Text('Booked Rooms'),
                  subtitle: const Text('Your past and upcoming bookings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Implement profile update logic
                  },
                ),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: Get.isDarkMode,
                  onChanged: (value) {
                    Get.changeThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
