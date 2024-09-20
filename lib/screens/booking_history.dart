import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';

class BookingHistoryScreen extends GetView<BookingController> {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookings.isEmpty) {
          return const Center(child: Text('No bookings found'));
        }
        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            var booking = controller.bookings[index];
            return _buildBookingItem(booking);
          },
        );
      }),
    );
  }

  Widget _buildBookingItem(Booking booking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(

        decoration: BoxDecoration(

            boxShadow: [
              BoxShadow(
                color: Get.theme.dividerColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(1, 1),
              ), // Shadow position (horizontal, vertical)
            ],
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Room: ${booking.roomType}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.monetization_on, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Price: ${booking.price}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.chair, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Amenities: ${booking.amenities!.join(' | ')}',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Booked Time: ${DateFormat('dd MMM, yy hh:mm a').format(booking.checkInTime!.toDate())}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
