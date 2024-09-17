import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/firebase_options.dart';
import 'package:hotel_app/screens/sign_up.dart';
import 'screens/login_screen.dart';
import 'screens/room_list_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/booking_history_screen.dart';
import 'screens/guest_management_screen.dart';
import 'screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Hotel App',
    options: DefaultFirebaseOptions.android,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signUP', page: () => SignUpScreen()),
        GetPage(name: '/rooms', page: () => RoomListScreen()),
        GetPage(
            name: '/book-room', page: () => BookingScreen(room: Get.arguments)),
        GetPage(name: '/booking-history', page: () => BookingHistoryScreen()),
        GetPage(name: '/guest-management', page: () => GuestManagementScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
      ],
    );
  }
}
