import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Profile'),
                  subtitle: const Text('Update your profile information'),
                  trailing: const Icon(Icons.person),
                  onTap: () {
                    // Implement profile update logic
                  },
                ),
                ListTile(
                  title: const Text('Previous Rooms'),
                  subtitle: const Text('Previously booked rooms'),
                  trailing: const Icon(Icons.hotel_rounded),
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
