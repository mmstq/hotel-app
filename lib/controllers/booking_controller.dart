import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/helper_functions.dart';
import 'package:hotel_app/models/booking.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/provider/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController extends GetxController {
  Room? room;
  final formKey = GlobalKey<FormState>();
  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  final provider = Get.find<BaseProvider>();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final guestEmailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    room = Get.arguments?['room'] as Room?;
    fetchBookingHistory();
    super.onInit();
  }

  Future<void> fetchBookingHistory() async {
    isLoading.value = true;
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userEmail = currentUser.email ?? '';
      QuerySnapshot bookingSnapshot =
          await _firestore.collection('room-booking').where(isStaff?'staffEmail':'userEmail', isEqualTo: userEmail).get();
      bookings.value = bookingSnapshot.docs.map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>)).toList();
    }
    isLoading.value = false;
  }

  Future<void> bookRoom(String payment) async {
    isLoading.value = true;
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userEmail = currentUser.email ?? '';
      Booking newBooking = Booking(
        userEmail: isStaff ? guestEmailController.text : userEmail,
        roomId: room!.id,
        roomType: room!.roomType!,
        price: room!.price,
        checkInTime: room!.checkInTime,
        checkOutTime: room!.checkOutTime,
        amenities: room!.amenities,
        staffEmail: isStaff ? userEmail : null,
        paymentMethod: payment,
      );
      await _firestore.collection('room-booking').add(newBooking.toJson());
      await _firestore.collection('rooms').doc(room!.id).update({
        'userEmail': isStaff ? guestEmailController.text : userEmail,
        'checkinTime': room!.checkInTime,
        'checkoutTime': room!.checkOutTime,
        'isBooked': true,
        if(isStaff) 'staffEmail': userEmail,
      });
      Get.snackbar('Success', 'Room booked successfully', backgroundColor: Colors.blue);
      if(isStaff) {
        Get.toNamed('/guestDashboard');
      } else {
        Get.toNamed('/booking-history');

      }
    } else {
      Get.snackbar('Error', 'You must be logged in to book a room', backgroundColor: Colors.red);
    }
    isLoading.value = false;
  }
}
