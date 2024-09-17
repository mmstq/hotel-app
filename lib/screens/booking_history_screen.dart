import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_controller.dart';

class BookingHistoryScreen extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
      ),
      body: Obx(() {
        if (bookingController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (bookingController.bookings.isEmpty) {
          return Center(child: Text('No bookings found'));
        }
        return ListView.builder(
          itemCount: bookingController.bookings.length,
          itemBuilder: (context, index) {
            var booking = bookingController.bookings[index];
            return ListTile(
              title: Text('Room ${booking.room.number} - ${booking.room.type}'),
              subtitle: Text(
                'Check-In: ${booking.checkInDate}, Check-Out: ${booking.checkOutDate}',
              ),
              trailing: Text(booking.status),
            );
          },
        );
      }),
    );
  }
}
