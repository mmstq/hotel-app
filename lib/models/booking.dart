
import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? userEmail;
  String? roomId;
  String? roomType;
  double? price;
  Timestamp? checkinTime;
  Timestamp? checkoutTime;
  List<String>? amenities;
  bool? isBooked;
  String? paymentMethod;

  Booking({
    required this.userEmail,
    required this.roomId,
    required this.roomType,
    required this.price,
    required this.checkinTime,
    required this.checkoutTime,
    required this.amenities,
    required this.isBooked,
    required this.paymentMethod,
  });

  // Convert Booking object to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'roomId': roomId,
      'roomType': roomType,
      'price': price,
      'checkinTime': checkinTime, // Format time for saving
      'checkoutTime': checkoutTime,
      'amenities': amenities,
      'isBooked': isBooked,
      'paymentMethod': paymentMethod,
    };
  }

  // Create Booking object from Firestore data
  factory Booking.fromJson(Map<String, dynamic> json) {

    return Booking(
      userEmail: json['userEmail'],
      roomId: json['roomId'],
      roomType: json['roomType'],
      price: json['price'],
      amenities : json['amenities'].cast<String>(),
      checkinTime : (json['checkinTime']as Timestamp),
      checkoutTime : (json['checkoutTime']as Timestamp),
      isBooked: json['isBooked'],
      paymentMethod: json['paymentMethod'],
    );
  }
}
