import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/models/booking.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/provider/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController extends GetxController {

  Room? room;
  final formKey = GlobalKey<FormState>();
  var bookings = <Booking>[].obs; // List to store all bookings
  var isLoading = false.obs; // Loading indicator
  final provider = Get.find<BaseProvider>();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    room =  Get.arguments?['room'] as Room?;
    fetchBookingHistory(); // Fetch booking history when controller is initialized
    super.onInit();
  }

  // Fetch booking history based on the current user's email
  Future<void> fetchBookingHistory() async {
    isLoading.value = true;
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      String userEmail = currentUser.email ?? '';

      // Fetch bookings from Firestore where the user email matches
      QuerySnapshot bookingSnapshot = await _firestore
          .collection('room-booking')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      bookings.value = bookingSnapshot.docs
          .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
          .toList(); // Map Firestore data to Booking model
    }

    isLoading.value = false;
  }

  // Book a room
  Future<void> bookRoom(Room room) async {
    isLoading.value = true;
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      String userEmail = currentUser.email ?? '';

      // Create a new booking object
      Booking newBooking = Booking(
        userEmail: userEmail,
        roomId: room.id,
        roomType: room.roomType!,
        price: room.price,
        checkInTime: room.checkInTime,
        checkOutTime: room.checkOutTime,
        amenities: room.amenities,
        isBooked: true,
        paymentMethod: 'paymentMethod',
      );

      // Save booking to Firestore
      await _firestore.collection('room-booking').add(newBooking.toJson());

      Get.snackbar('Success', 'Room booked successfully');
      fetchBookingHistory(); // Refresh booking history after booking
    } else {
      Get.snackbar('Error', 'You must be logged in to book a room');
    }

    isLoading.value = false;
  }

  // Cancel a booking
  Future<void> cancelBooking(String bookingId) async {
    isLoading.value = true;

    // Remove booking from Firestore
    await _firestore.collection('bookings').doc(bookingId).delete();

    Get.snackbar('Success', 'Booking cancelled successfully');
    fetchBookingHistory(); // Refresh booking history after cancellation

    isLoading.value = false;
  }
}
