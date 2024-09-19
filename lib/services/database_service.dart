import 'package:flutter/material.dart';
import 'package:hotel_app/models/booking.dart';
import 'package:hotel_app/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference roomsCollection =
  FirebaseFirestore.instance.collection('rooms');  // Firestore reference to "rooms" collection

  // Fetch rooms from Firestore
  Future<List<Room>> getRooms() async {
    try {
      QuerySnapshot snapshot = await roomsCollection.get();
      return snapshot.docs.map((doc) {
        // Convert Firestore document to Room object
        return Room(
          id: doc['id'] ?? '',
          number: doc['number'] ?? 0,
          type: doc['type'] ?? 'Unknown',
          price: doc['price']?.toDouble() ?? 0.0,
          checkinTime: TimeOfDay(hour: doc['checkinHour'], minute: doc['checkinMinute']),
          checkoutTime: TimeOfDay(hour: doc['checkoutHour'], minute: doc['checkoutMinute']),
          isBooked: doc['isBooked'] ?? false,
          amenities: doc['amenities'] ?? 'No amenities listed',
        );
      }).toList();
    } catch (e) {
      print('Error getting rooms from Firestore: $e');
      return [];  // Return an empty list in case of an error
    }
  }
}


class BookingService {
  // Simulate fetching booking data for the current user
  Future<List<Booking>> getUserBookings() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Example list of bookings (you can replace this with an API call)
    return [
      Booking(
        id: '1',
        room: Room(
          number: 1,
          price: 50,
          isBooked: true,
          id: 'R3',
          checkinTime: TimeOfDay.now(),
          checkoutTime: TimeOfDay.now(),
          type: 'Deluxe',
          amenities: '',
        ),
        checkInDate: DateTime(2023, 8, 1),
        checkOutDate: DateTime(2023, 8, 5),
        status: 'completed',
      ),
      Booking(
        id: '2',
        room: Room(
          price: 60,
          number: 2,
          isBooked: true,
          id: 'R3',
          checkinTime: TimeOfDay.now(),
          checkoutTime: TimeOfDay.now(),
          type: 'Deluxe',
          amenities: '',
        ),
        checkInDate: DateTime(2024, 3, 15),
        checkOutDate: DateTime(2024, 3, 20),
        status: 'upcoming',
      ),
    ];
  }
}
