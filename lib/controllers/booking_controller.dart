import 'package:get/get.dart';
import '../models/booking.dart';

class BookingController extends GetxController {
  var bookings = <Booking>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() async {

  }

  void createBooking(Booking booking) {
    bookings.add(booking);
    bookings.refresh();
    Get.snackbar('Success', 'Booking created successfully');
  }

  void cancelBooking(Booking booking) {
    bookings.remove(booking);
    bookings.refresh();
    Get.snackbar('Success', 'Booking canceled');
  }
}
