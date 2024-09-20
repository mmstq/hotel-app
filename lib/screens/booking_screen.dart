import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/text_field.dart';
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
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/room_icon.png',
                      fit: BoxFit.cover,
                      color: Get.theme.primaryColorLight,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Room Package', style: Get.theme.textTheme.labelLarge),
                    Text(
                      controller.room!.roomType!,
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Per Night', style: Get.theme.textTheme.labelLarge),
                    Text(
                      '₹${controller.room!.price!.toInt()} ',
                      style: Get.theme.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amenities', style: Get.theme.textTheme.labelLarge),
                    Wrap(
                      spacing: 12.0,
                      runSpacing: 0.0,
                      children: generateChips(
                        controller.room!.amenities!,
                      ), // Call the method here
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                    final Timestamp? time =
                        await _selectAndDisplayTime(context);
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
                    final Timestamp? time =
                        await _selectAndDisplayTime(context);
                    controller.checkOutController.text =
                        DateFormat('dd-MM-yyyy hh:mm a').format(time!.toDate());
                  },
                  label: 'Check-out-time',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InputButton(
          label: Text(
            'Book',
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

  List<Widget> generateChips(List<String> labels) {
    return labels.map((label) {
      return Chip(
        label: Text(
          label,
          style: TextStyle(color: Colors.blue.shade600),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        backgroundColor: Colors.blue.shade100,
      );
    }).toList();
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
                // controller.bookRoom(controller.room!);
                Get.off(() => _buildOrderConfirmation());
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
      decoration: BoxDecoration(color: Get.theme.cardColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'Confirmed',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Thank you for your booking room.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Check the status of your booking on the booking history page.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: InputButton(
                  label: Text(
                    'Done',
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  labelColor:
                      Get.theme.textTheme.displaySmall!.color!.withOpacity(1),
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    Get.toNamed('/guestDashboard');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
