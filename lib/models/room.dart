
class Room {
  int? roomNo;
  String? roomType;
  String? id;
  double? price;
  bool? isBooked;
  List<String>? amenities;
  int? checkinTime;
  int? checkoutTime;

  Room(
      {this.roomNo,
        this.roomType,
        this.id,
        this.price,
        this.isBooked,
        this.amenities,
        this.checkinTime,
        this.checkoutTime});

  Room.fromJson(Map<String, dynamic> json) {
    roomNo = json['roomNo'];
    roomType = json['roomType'];
    id = json['id'];
    price = json['price'];
    isBooked = json['isBooked'];
    amenities = json['amenities'].cast<String>();
    checkinTime = json['checkinTime'];
    checkoutTime = json['checkoutTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomNo'] = roomNo;
    data['roomType'] = roomType;
    data['id'] = id;
    data['price'] = price;
    data['isBooked'] = isBooked;
    data['amenities'] = amenities;
    data['checkinTime'] = checkinTime;
    data['checkoutTime'] = checkoutTime;
    return data;
  }
}
