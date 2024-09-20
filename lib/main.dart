import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/app_binding.dart';
import 'package:hotel_app/bindings/auth_binding.dart';
import 'package:hotel_app/bindings/booking_binding.dart';
import 'package:hotel_app/bindings/dashboard_binding.dart';
import 'package:hotel_app/bindings/profile_binding.dart';
import 'package:hotel_app/firebase_options.dart';
import 'package:hotel_app/middleware/middle_ware.dart';
import 'package:hotel_app/screens/guest_dashboard.dart';
import 'package:hotel_app/screens/profile.dart';
import 'package:hotel_app/screens/sign_up.dart';
import 'screens/sign_in.dart';
import 'screens/booking_screen.dart';
import 'screens/booking_history.dart';
import 'screens/account.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Hotel App',
    options: DefaultFirebaseOptions.android,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Star Hotel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade50)),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      initialBinding: AppBinding(),
      themeMode: ThemeMode.system,
      initialRoute: '/guestDashboard',
      getPages: [
        GetPage(name: '/login', page: () => SignInScreen()),
        GetPage(name: '/signUP', page: () => const SignUpScreen(), binding: AuthBinding()),
        // GetPage(name: '/rooms', page: () => RoomListScreen()),
        GetPage(
          name: '/guestDashboard',
          page: () => const DashboardScreen(),
          binding: DashboardBinding(),
          middlewares: [
            AuthMiddleware(),
          ],
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
          binding: ProfileBinding(),
          middlewares: [
            AuthMiddleware(),
          ],
        ),
        GetPage(
          name: '/book-room',
          page: () => const BookingScreen(),
          binding: BookingBinding(),
          middlewares: [
            AuthMiddleware(),
          ],
        ),
        GetPage(
          name: '/booking-history',
          page: () => const BookingHistoryScreen(),
          binding: BookingBinding(),
          middlewares: [
            AuthMiddleware(),
          ],
        ),
        GetPage(
          name: '/account',
          page: () => AccountScreen(),
          middlewares: [
            AuthMiddleware(),
          ],
        ),
      ],
    );
  }
}
