import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/dialog.dart';
import 'package:hotel_app/controllers/auth_controller.dart';
import 'package:hotel_app/screens/booking_history_screen.dart';
import 'package:hotel_app/screens/profile.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart'; // For file storage

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _imagePath; // Variable to store image path

  @override
  void initState() {
    super.initState();
    _loadImage(); // Load the saved image when the screen is initialized
  }

  // Function to pick and save an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Save the image to local file system and then store the path
      final File imageFile = await _saveImageLocally(pickedImage);
      setState(() {
        _imagePath = imageFile.path; // Save the local file path
      });
      _saveImagePath(
          imageFile.path); // Save the image path in SharedPreferences
    }
  }

  // Save the image path to SharedPreferences
  Future<void> _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', path);
  }

  // Load the image path from SharedPreferences and check if the file exists
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedImagePath = prefs.getString('profile_image');

    if (savedImagePath != null && File(savedImagePath).existsSync()) {
      setState(() {
        _imagePath = savedImagePath; // Load the saved image path
      });
    }
  }

  // Save the selected image to the local file system
  Future<File> _saveImageLocally(XFile image) async {
    final directory =
        await getApplicationDocumentsDirectory(); // Get local directory
    final String path = directory.path;
    final File newImage =
        File('$path/profile_image.png'); // Define a local path for the image

    return File(image.path)
        .copy(newImage.path); // Copy image to the new local path
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
                  backgroundImage: _imagePath != null
                      ? FileImage(File(
                          _imagePath!)) // Load the image from local storage
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                title: const Text('Booked Rooms'),
                subtitle: const Text('Your past and upcoming bookings'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingHistoryScreen(),
                    ),
                  );
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
              Row(
                children: [
                  _buildLogoutButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: _showCustomSignOutDialog,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 4, 24, 4),
        alignment: Alignment.bottomLeft,
        child: Text(
          'Log Out',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  void _showCustomSignOutDialog() {
    CustomDialog(
      barrierDismissible: false,
      onSubmitted: () => AuthController().logout(),
      onCanceled: () {},
      actionText: 'Yes!',
      cancelText: 'Cancel',
      content: Column(
        children: [
          const SizedBox(height: 22),
          const Icon(
            CupertinoIcons.power,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 12),
          Text(
            'Logout Account',
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              height: 3.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Are you sure you want to logout? Once you logout you need to login again?',
            textAlign: TextAlign.center,
            style: Get.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.normal,
              height: 2.0,
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    ).show();
  }
}
