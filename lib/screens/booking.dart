import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/time_picker.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/screens/payment.dart';
import '../controllers/booking_controller.dart';

class BookingScreen extends StatelessWidget {
  final Room room;
  final BookingController bookingController = Get.put(BookingController());

  BookingScreen({super.key, required this.room});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Book Room ${room.number}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Image.asset(
                'assets/room_icon.png',
                fit: BoxFit.cover,
                color: Get.theme.primaryColorLight,
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room Package',
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                          fontSize: 14,
                          color: Get.theme.textTheme.labelSmall!.color
                              ?.withOpacity(0.7)),
                    ),
                    Text(
                      room.type,
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price/minute',
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                          fontSize: 14,
                          color: Get.theme.textTheme.labelSmall!.color
                              ?.withOpacity(0.7)),
                    ),
                    Text(
                      ' \$${room.price} ',
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amenities',
                        style: Get.theme.textTheme.headlineLarge!.copyWith(
                            fontSize: 14,
                            color: Get.theme.textTheme.labelSmall!.color
                                ?.withOpacity(0.7)),
                      ),
                      SizedBox(
                        height: 60,
                        child: Text(
                          '${room.amenities} ',
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                          style: Get.theme.textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const TimePickerWidget(
              label: 'Check-in-time',
            ),
            const TimePickerWidget(
              label: 'Check-out-time',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InputButton(
          label: 'Book Now',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute( builder: (context) => PaymentScreen()));
            // User user = User(
            //     id: '1',
            //     name: 'John Doe',
            //     email: 'john@example.com',
            //     role: 'guest'); // Example user
            // Booking booking = Booking(
            //   id: DateTime.now().toString(),
            //   room: room,
            //   user: user,
            //   checkInDate: DateTime.parse(_checkInDateController.text),
            //   checkOutDate: DateTime.parse(_checkOutDateController.text),
            // );
            // bookingController.createBooking(booking);
            // Get.back();
          },
        ),
      ),
    );
  }
}
