import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/dialog.dart';
import 'package:hotel_app/controllers/auth_controller.dart';
import 'package:hotel_app/screens/booking_history.dart';
import 'package:hotel_app/screens/profile.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
