// payment.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/text_field.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/controllers/payment_controller.dart';
import 'package:hotel_app/screens/guest_dashboard.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());

    // Reset state each time the screen is built
    controller.resetState();

    return Scaffold(
      body: Obx(() {
        if (controller.isOrderConfirmed.value) {
          return _buildOrderConfirmation(context);
        } else {
          return _buildPaymentForm(context);
        }
      }),
    );
  }

  // Payment Form UI
  Widget _buildPaymentForm(BuildContext context) {
    final PaymentController controller = Get.find<PaymentController>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Credit Card Section
          const Text(
            'Credit Card',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Obx(
            () => RadioListTile(
              activeColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  width: 2,
                  color: controller.selectedPaymentMethod.value == 0
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
              value: 0,
              groupValue: controller.selectedPaymentMethod.value,
              onChanged: (value) {
                controller.selectedPaymentMethod.value = value as int;
              },
              title: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: controller.selectedPaymentMethod.value == 0
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Credit Card',
                    style: TextStyle(
                      color: controller.selectedPaymentMethod.value == 0
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (controller.selectedPaymentMethod.value == 0)
             const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Card(
                elevation: 0.5,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextInputField(
                        label: 'Card Number',
                        suffixIcon: Icon(Icons.credit_card, color: Colors.blue),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextInputField(
                              label: 'MM/YY',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextInputField(
                              label: 'CVC',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          // PayPal Option
          Obx(
            () => RadioListTile(
              activeColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  width: 2,
                  color: controller.selectedPaymentMethod.value == 1
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
              value: 1,
              groupValue: controller.selectedPaymentMethod.value,
              onChanged: (value) {
                controller.selectedPaymentMethod.value = value as int;
              },
              title: Row(
                children: [
                  Icon(
                    Icons.paypal,
                    color: controller.selectedPaymentMethod.value == 1
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'PayPal',
                    style: TextStyle(
                      color: controller.selectedPaymentMethod.value == 1
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Apple Pay Option
          Obx(
            () => RadioListTile(
              activeColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  width: 2,
                  color: controller.selectedPaymentMethod.value == 2
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
              value: 2,
              groupValue: controller.selectedPaymentMethod.value,
              onChanged: (value) {
                controller.selectedPaymentMethod.value = value as int;
              },
              title: Row(
                children: [
                  Icon(
                    Icons.apple,
                    color: controller.selectedPaymentMethod.value == 2
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Apple Pay',
                    style: TextStyle(
                      color: controller.selectedPaymentMethod.value == 2
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Order Total and Confirm Button
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grand Total', style: TextStyle(fontSize: 18)),
              Text('\$19.99', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: InputButton(
              label: Text(
                'Confirm Booking',
                style: Get.theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                controller.isOrderConfirmed.value = true;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Order Confirmation UI
  Widget _buildOrderConfirmation(BuildContext context) {
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
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                        (route) => false);
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
