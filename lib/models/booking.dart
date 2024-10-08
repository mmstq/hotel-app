
import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? userEmail;
  String? roomId;
  String? roomType;
  double? price;
  Timestamp? checkInTime;
  Timestamp? checkOutTime;
  List<String>? amenities;
  String? staffEmail;
  String? paymentMethod;

  Booking({
    this.userEmail,
    this.roomId,
    this.roomType,
    this.price,
    this.checkInTime,
    this.checkOutTime,
    this.amenities,
    this.staffEmail,
    this.paymentMethod,
  });

  // Convert Booking object to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'roomId': roomId,
      'roomType': roomType,
      'price': price,
      'checkinTime': checkInTime, // Format time for saving
      'checkoutTime': checkOutTime,
      'amenities': amenities,
      'staffEmail': staffEmail,
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
      checkInTime : (json['checkinTime']),
      checkOutTime : (json['checkoutTime']),
      staffEmail: json['staffEmail'],
      paymentMethod: json['paymentMethod'],
    );
  }
}
