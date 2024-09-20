
import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  int? roomNo;
  String? roomType;
  String? id;
  double? price;
  bool? isBooked;
  List<String>? amenities;
  Timestamp? checkInTime;
  Timestamp? checkOutTime;
  String? image;

  Room(
      {this.roomNo,
        this.roomType,
        this.id,
        this.price,
        this.isBooked,
        this.amenities,
        this.checkInTime,
        this.checkOutTime,
        this.image,
      });

  Room.fromJson(Map<String, dynamic> json) {
    roomNo = json['roomNo'];
    roomType = json['roomType'];
    id = json['id'];
    price = json['price'];
    isBooked = json['isBooked'];
    amenities = json['amenities'].cast<String>();
    checkInTime = json['checkinTime'];
    checkOutTime = json['checkoutTime'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomNo'] = roomNo;
    data['roomType'] = roomType;
    data['id'] = id;
    data['price'] = price;
    data['isBooked'] = isBooked;
    data['amenities'] = amenities;
    data['checkinTime'] = checkInTime;
    data['checkoutTime'] = checkOutTime;
    data['image'] = image;
    return data;
  }
}
