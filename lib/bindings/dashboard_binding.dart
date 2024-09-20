import 'package:get/get.dart';
import 'package:hotel_app/controllers/room_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RoomController>(RoomController());
  }

}