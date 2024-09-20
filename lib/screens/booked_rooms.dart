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
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            InkWell(
              onTap: () => Get.toNamed('/guestDashboard',  arguments: {'booked':true}),
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Get.theme.cardColor

                ),
                child: Text('Booked Rooms', style: Get.textTheme.titleMedium,),
              ),
            ),
            const SizedBox(height: 24,),
            InkWell(
              onTap: () => Get.toNamed('/guestDashboard', arguments: {'booked':false}),
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Get.theme.cardColor

                ),
                child: Text('Book Rooms', style: Get.textTheme.titleMedium,),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
