import 'package:get/get.dart';
import 'package:hotel_app/controllers/auth_controller.dart';
import 'package:hotel_app/controllers/room_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }

}