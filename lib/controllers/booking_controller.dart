import 'package:get/get.dart';
import '../models/booking.dart';
import '../services/database_service.dart';

class BookingController extends GetxController {
  var bookings = <Booking>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  void fetchBookings() async {
    isLoading(true);
    try {
      var bookingList = await BookingService().getUserBookings();
      if (bookingList != null) {
        bookings.value = bookingList;
      }
    } finally {
      isLoading(false);
    }
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
