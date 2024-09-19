import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/models/user.dart';


class Booking {
  final String id;
  final Room room;
  // final User user;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  late final String status; // 'booked', 'checked-in', 'checked-out'

  Booking({
    required this.id,
    required this.room,
    // required this.user,
    required this.checkInDate,
    required this.checkOutDate,
    this.status = 'booked',
  });
}
