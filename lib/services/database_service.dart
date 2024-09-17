import 'package:hotel_app/models/room.dart';


class DatabaseService {
  Future<List<Room>> getRooms() async {
    // Dummy data for now, replace with SQLite or Firebase fetch
    await Future.delayed(const Duration(seconds: 1)); // simulate delay
    return [
      Room(number: 101, type: 'Deluxe', price: 120, isAvailable: true),
      Room(number: 102, type: 'Standard', price: 80, isAvailable: true),
      Room(number: 103, type: 'Suite', price: 200, isAvailable: false),
    ];
  }

  getBookings() {}
}
