import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:hotel_app/components/time_picker.dart';
import 'package:intl/intl.dart';
import '../controllers/booking_controller.dart';
import 'guest_dashboard.dart';

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
                        style: Get.theme.textTheme.headlineLarge!.copyWith(
                            fontSize: 14,
                            color: Get.theme.textTheme.labelSmall!.color
                                ?.withOpacity(0.7)),
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
                        style: Get.theme.textTheme.headlineLarge!.copyWith(
                            fontSize: 14,
                            color: Get.theme.textTheme.labelSmall!.color
                                ?.withOpacity(0.7)),
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
                          style: Get.theme.textTheme.headlineLarge!.copyWith(
                              fontSize: 14,
                              color: Get.theme.textTheme.labelSmall!.color
                                  ?.withOpacity(0.7)),
                        ),
                        SizedBox(
                          height: 60,
                          child: Text(
                            '${controller.room!.amenities} ',
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
              TextInputField(
                isReadOnly: true,
                controller: controller.checkInController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select checkin time';
                  }
                  return null;
                },
                label: 'Check-in-time',
                onTap: () async {
                  final Timestamp? time = await _selectAndDisplayTime(context);
                  controller.checkInController.text =
                      DateFormat('dd-MM-yyyy hh:mm a').format(time!.toDate());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                isReadOnly: true,
                controller: controller.checkOutController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select checkout time';
                  }
                  return null;
                },
                onTap: () async {
                  final Timestamp? time = await _selectAndDisplayTime(context);
                  controller.checkOutController.text =
                      DateFormat('dd-MM-yyyy hh:mm a').format(time!.toDate());
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
            'Pay',
            style: Get.theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              _showPaymentOptions();
            }
          },
        ),
      ),
    );
  }

  Future<Timestamp?> _selectAndDisplayTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      final Timestamp selectedTimestamp = Timestamp.fromDate(selectedDateTime);
      return selectedTimestamp;
    }
    return null;
  }

  void _showPaymentOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit/Debit Card'),
              onTap: () {
                _handlePayment('card');
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_android_outlined),
              title: const Text('UPI'),
              onTap: () {
                _handlePayment('upi');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Pay on Checkout'),
              onTap: () {
                _handlePayment('pay_on_checkout');
              },
            ),
            InputButton(
              onPressed: () {
                controller.bookRoom(controller.room!);
              },
              label: const Text(
                'Book Now',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handlePayment(String paymentMethod) {}

  Widget _buildOrderConfirmation() {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              const Text(
                'Confirmed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Thank you for your booking room. You will receive an email confirmation shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Check the status of your booking on the booking tracking page.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: InputButton(
                  label: Text(
                    'Continue Shopping',
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  labelColor:
                      Get.theme.textTheme.displaySmall!.color!.withOpacity(1),
                  backgroundColor: Get.theme.cardColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
