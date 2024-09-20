import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:hotel_app/components/time_picker.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';

class BookingScreen extends GetView<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Book Room ${controller.room!.roomNo}'),
      ),
      body: Form(
        key: controller.formKey,
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
                        style: Get.theme.textTheme.headlineLarge!
                            .copyWith(fontSize: 14, color: Get.theme.textTheme.labelSmall!.color?.withOpacity(0.7)),
                      ),
                      Text(
                        controller.room!.roomType!,
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
                        style: Get.theme.textTheme.headlineLarge!
                            .copyWith(fontSize: 14, color: Get.theme.textTheme.labelSmall!.color?.withOpacity(0.7)),
                      ),
                      Text(
                        ' \$${controller.room!.price} ',
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
                          style: Get.theme.textTheme.headlineLarge!
                              .copyWith(fontSize: 14, color: Get.theme.textTheme.labelSmall!.color?.withOpacity(0.7)),
                        ),
                        SizedBox(
                          height: 60,
                          child: Text(
                            '${controller.room!.amenities} ',
                            maxLines: 4,
                            overflow: TextOverflow.clip,
                            style: Get.theme.textTheme.headlineLarge!
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextInputField(
                controller: controller.checkInController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select checkin time';
                  }
                  return null;
                },
                label: 'Check-in-time',
                onTap: ()async{
                  final Timestamp? time = await _selectAndDisplayTime(context);
                  controller.checkInController.text = DateFormat('dd-MM-yyyy hh:mm a').format(time!.toDate());

                },
              ),
              const SizedBox(height: 20,),
              TextInputField(
                controller: controller.checkOutController,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select checkout time';
                  }
                  return null;
                },
                onTap: ()async{
                  final Timestamp? time = await _selectAndDisplayTime(context);
                  controller.checkOutController.text = DateFormat('dd-MM-yyyy hh:mm a').format(time!.toDate());

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
            if (controller.formKey.currentState!.validate()) {
              controller.bookRoom(controller.room!);
            }
          },
        ),
      ),
    );
  }

  // Combined function to handle time selection and conversion
  Future<Timestamp?> _selectAndDisplayTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Get the current date
      final now = DateTime.now();

      // Create a DateTime object with the current date and selected time
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // Convert the DateTime to a Firestore Timestamp
      final Timestamp selectedTimestamp = Timestamp.fromDate(selectedDateTime);

      // Return the Firestore Timestamp
      return selectedTimestamp;
    }

    // Return null if no time was selected
    return null;
  }
}
