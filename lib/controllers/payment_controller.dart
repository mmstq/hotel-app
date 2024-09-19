// payment_controller.dart
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedPaymentMethod = 0.obs;
  var isOrderConfirmed = false.obs;

  @override
  void onInit() {
    super.onInit();
    resetState(); // Reset state when the controller is initialized
  }

  void resetState() {
    selectedPaymentMethod.value = 0;
    isOrderConfirmed.value = false;
  }
}
