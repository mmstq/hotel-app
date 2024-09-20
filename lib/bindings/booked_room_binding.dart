import 'package:get/get.dart';
import 'package:hotel_app/controllers/booking_controller.dart';

class BookedRoomBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<BookingController>(BookingController());
  }

}