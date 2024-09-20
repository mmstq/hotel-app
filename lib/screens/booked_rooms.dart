import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/controllers/booking_controller.dart';
import 'package:hotel_app/models/booking.dart';

class BookedRoomsScreen extends GetView<BookingController> {
  const BookedRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Rooms'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookings.isEmpty) {
          return const Center(child: Text('No rooms booked yet.'));
        }

        // Display list of booked rooms from Firestore
        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            var booking = controller.bookings[index];
            return ListTile(
              title: Text('Room: ${booking.roomType}'),
              subtitle: Text('Price: \$${booking.price}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Show booking details in a modal bottom sheet
                _showBookingDetails(context, booking);
              },
            );
          },
        );
      }),
    );
  }

  // Function to show booking details in a modal bottom sheet
  void _showBookingDetails(BuildContext context, Booking booking) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Details',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 10),
              Text('Room Type: ${booking.roomType}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Price: \$${booking.price}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Amenities: ${booking.amenities}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Payment Method: ${booking.paymentMethod}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Check-In Time: ${booking.checkInTime}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Check-Out Time: ${booking.checkOutTime}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Booked By: ${booking.userEmail}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
