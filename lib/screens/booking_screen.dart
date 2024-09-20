import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/time_picker.dart';
import 'package:hotel_app/models/room.dart';
import '../controllers/booking_controller.dart';

class BookingScreen extends GetView<BookingController> {
  final Room room;
  final _formKey = GlobalKey<FormState>();

  BookingScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Book Room ${room.roomNo}'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                        room.roomType!,
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
              TimePickerWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select checkin time';
                  }
                  return null;
                },
                label: 'Check-in-time',
              ),
              TimePickerWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select checkout time';
                  }
                  return null;
                },
                label: 'Check-out-time',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InputButton(
          label: Text(
            'Book Now',
            style: Get.theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              controller.bookRoom(room);
            }
          },
        ),
      ),
    );
  }
}
