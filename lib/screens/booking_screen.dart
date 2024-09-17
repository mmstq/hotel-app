import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/custom_input_widgets.dart';
import 'package:hotel_app/components/input_button.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/models/user.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';

class BookingScreen extends StatelessWidget {
  final Room room;
  final BookingController bookingController = Get.put(BookingController());

  BookingScreen({super.key, required this.room});

  final _checkInDateController = TextEditingController();
  final _checkOutDateController = TextEditingController();

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
                      style: Get.theme.textTheme.headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
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
                      'Price/mint',
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                          fontSize: 14,
                          color: Get.theme.textTheme.labelSmall!.color
                              ?.withOpacity(0.7)),
                    ),
                    Text(
                      ' \$${room.price} ',
                      style: Get.theme.textTheme.headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
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
                      SizedBox(height: 60,
                        child: Text(
                          '${room.amenities} ',
                          maxLines: 4,
                          overflow: TextOverflow.clip,
                          style: Get.theme.textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
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
            // TextInputField(
            //   isReadOnly: true,
            //   label: 'Check-In Time',
            //   controller: _checkInDateController,
            //   onTap: () async {
            //     TimeOfDay? picked = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.now(),
            //     );
            //     if (picked != null) {
            //       // Format time in a readable format
            //       final now = DateTime.now();
            //       final formattedTime = DateTime(
            //         now.year,
            //         now.month,
            //         now.day,
            //         picked.hour,
            //         picked.minute,
            //       );
            //       _checkInDateController.text = formattedTime.toString();
            //     }
            //   },
            // ),
            // TextField(
            //   readOnly: true,
            //   controller: _checkInDateController,
            //   decoration: const InputDecoration(
            //     labelText: 'Check-In Time',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(8)),
            //     ),
            //   ),
            //   onTap: () async {
            //     TimeOfDay? picked = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.now(),
            //     );
            //     if (picked != null) {
            //       // Format time in a readable format
            //       final now = DateTime.now();
            //       final formattedTime = DateTime(
            //         now.year,
            //         now.month,
            //         now.day,
            //         picked.hour,
            //         picked.minute,
            //       );
            //       _checkInDateController.text = formattedTime.toString();
            //     }
            //   },
            // ),
            // const SizedBox(height: 10),
            // TextInputField(
            //   isReadOnly: true,
            //   controller: _checkOutDateController,
            //   label: 'Check-Out Time',
            //   onTap: () async {
            //     TimeOfDay? picked = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.now(),
            //     );
            //     if (picked != null) {
            //       // Format time in a readable format
            //       final now = DateTime.now();
            //       final formattedTime = DateTime(
            //         now.year,
            //         now.month,
            //         now.day,
            //         picked.hour,
            //         picked.minute,
            //       );
            //       _checkOutDateController.text = formattedTime.toString();
            //     }
            //   },
            // ),
            // TextField(
            //   readOnly: true,
            //   controller: _checkOutDateController,
            //   decoration: const InputDecoration(
            //     labelText: 'Check-Out Time',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(8)),
            //     ),
            //   ),
            //   onTap: () async {
            //     TimeOfDay? picked = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.now(),
            //     );
            //     if (picked != null) {
            //       // Format time in a readable format
            //       final now = DateTime.now();
            //       final formattedTime = DateTime(
            //         now.year,
            //         now.month,
            //         now.day,
            //         picked.hour,
            //         picked.minute,
            //       );
            //       _checkOutDateController.text = formattedTime.toString();
            //     }
            //   },
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InputButton(
          label: 'Book Now',
          onPressed: () {
            User user = User(
                id: '1',
                name: 'John Doe',
                email: 'john@example.com',
                role: 'guest'); // Example user
            Booking booking = Booking(
              id: DateTime.now().toString(),
              room: room,
              user: user,
              checkInDate: DateTime.parse(_checkInDateController.text),
              checkOutDate: DateTime.parse(_checkOutDateController.text),
            );
            bookingController.createBooking(booking);
            Get.back();
          },
        ),
      ),
    );
  }
}
