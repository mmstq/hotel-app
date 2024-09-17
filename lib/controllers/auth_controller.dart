import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  final AuthService _authService = AuthService();

  // Method for login
  Future<void> login(String email, String password) async {
    User? user = await _authService.signInWithEmail(email, password);
    if (user != null) {
      isAuthenticated.value = true;
    } else {
      Get.snackbar("Error", "Login failed");
    }
  }

  // Method for registration
  Future<void> register(String email, String password) async {
    User? user = await _authService.registerWithEmail(email, password);
    if (user != null) {
      isAuthenticated.value = true;
    } else {
      Get.snackbar("Error", "Registration failed");
    }
  }

  // Method for logout
  void logout() async {
    await _authService.signOut();
    isAuthenticated.value = false;
    Get.offAllNamed('/login');
  }
}
