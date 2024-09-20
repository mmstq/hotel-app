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
  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  final provider = Get.find<BaseProvider>();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    room = Get.arguments?['room'] as Room?;
    fetchBookingHistory();
    fetchBookings();
    super.onInit();
  }

  Future<void> fetchBookingHistory() async {
    isLoading.value = true;
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userEmail = currentUser.email ?? '';
      QuerySnapshot bookingSnapshot = await _firestore
          .collection('room-booking')
          .where('userEmail', isEqualTo: userEmail)
          .get();
      bookings.value = bookingSnapshot.docs
          .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    }
    isLoading.value = false;
  }

  // Fetch bookings from Firestore
  Future<void> fetchBookings() async {
    isLoading.value = true;
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('bookings') // Access 'bookings' collection in Firestore
            .get();

        bookings.value = snapshot.docs
            .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch bookings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bookRoom(Room room) async {
    isLoading.value = true;
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String userEmail = currentUser.email ?? '';
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
      await _firestore.collection('room-booking').add(newBooking.toJson());
      Get.snackbar('Success', 'Room booked successfully');
      fetchBookingHistory(); // Refresh booking history after booking
    } else {
      Get.snackbar('Error', 'You must be logged in to book a room');
    }
    isLoading.value = false;
  }
}
