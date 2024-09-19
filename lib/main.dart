import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/firebase_options.dart';
import 'package:hotel_app/screens/guest_dashboard.dart';
import 'package:hotel_app/screens/profile.dart';
import 'package:hotel_app/screens/sign_up.dart';
import 'screens/sign_in.dart';
import 'screens/room_list_screen.dart';
import 'screens/booking.dart';
import 'screens/booking_history.dart';
import 'screens/account.dart';
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => SignInScreen()),
        GetPage(name: '/signUP', page: () => SignUpScreen()),
        // GetPage(name: '/rooms', page: () => RoomListScreen()),
        GetPage(name: '/guestDashboard', page: () => DashboardScreen()),
        GetPage(name: '/profile', page: () =>  ProfileScreen()),
        GetPage(
            name: '/book-room', page: () => BookingScreen(room: Get.arguments)),
        GetPage(name: '/booking-history', page: () => BookingHistoryScreen()),
        GetPage(name: '/account', page: () => AccountScreen()),
      ],
    );
  }
}
