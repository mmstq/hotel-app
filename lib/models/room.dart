import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  final String id;
  final double number;
  final String type;
  final double price;
  final String amenities;
  final TimeOfDay checkinTime;
  final TimeOfDay checkoutTime;
  late final bool isBooked;

  Room({
    required this.id,
    required this.number,
    required this.type,
    required this.price,
    required this.amenities,
    required this.checkinTime,
    required this.checkoutTime,
    required this.isBooked,
  });

  factory Room.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Room(
      id: doc.id,
      number: data['roomNo'],
      type: data['type'],
      price: data['price']?.toDouble() ?? 0.0,
      amenities: data['amenities'],
      checkinTime: data['checkinTime'],
      checkoutTime: data['checkoutTime'],
      isBooked: data['isBooked'] ?? false,
    );
  }
}
