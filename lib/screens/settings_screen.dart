import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Profile'),
              subtitle: Text('Update your profile information'),
              trailing: Icon(Icons.person),
              onTap: () {
                // Implement profile update logic
              },
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: Get.isDarkMode,
              onChanged: (value) {
                Get.changeThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
