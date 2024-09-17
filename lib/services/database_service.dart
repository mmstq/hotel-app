import 'package:hotel_app/models/room.dart';

class DatabaseService {
  Future<List<Room>> getRooms() async {
    // Simulate a delay and return dummy rooms
    await Future.delayed(const Duration(seconds: 1));
    return [
      Room(
        number: 101,
        type: 'Deluxe',
        price: 120,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_1.jpg',
      ),
      Room(
        number: 102,
        type: 'Standard',
        price: 80,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_2.jpg',
      ),
      Room(
        number: 103,
        type: 'Suite',
        price: 200,
        isAvailable: false,
        imageUrl: 'assets/hotel_room_3.jpg',
      ),
      Room(
        number: 104,
        type: 'Single',
        price: 50,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_4.jpg',
      ),
      Room(
        number: 105,
        type: 'Double',
        price: 100,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_5.jpg',
      ),
      Room(
        number: 106,
        type: 'Deluxe',
        price: 80,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_6.jpg',
      ),
      Room(
        number: 107,
        type: 'Suite',
        price: 200,
        isAvailable: false,
        imageUrl: 'assets/hotel_room_7.jpg',
      ),
      Room(
        number: 108,
        type: 'Single',
        price: 50,
        isAvailable: true,
        imageUrl: 'assets/room_1.jpg',
      ),
      Room(
        number: 109,
        type: 'Double',
        price: 100,
        isAvailable: true,
        imageUrl: 'assets/room_2.jpg',
      ),
      Room(
        number: 110,
        type: 'Standard',
        price: 80,
        isAvailable: true,
        imageUrl: 'assets/room_3.jpg',
      ),
      Room(
        number: 111,
        type: 'Deluxe',
        price: 200,
        isAvailable: false,
        imageUrl: 'assets/room_4.jpg',
      ),
      Room(
        number: 112,
        type: 'Single',
        price: 50,
        isAvailable: true,
        imageUrl: 'assets/room_5.jpg',
      ),
      Room(
        number: 113,
        type: 'Double',
        price: 100,
        isAvailable: true,
        imageUrl: 'assets/room_6.jpg',
      ),
      Room(
        number: 114,
        type: 'Standard',
        price: 80,
        isAvailable: true,
        imageUrl:'assets/room_7.jpg',
      ),
      Room(
        number: 115,
        type: 'Suite',
        price: 200,
        isAvailable: false,
        imageUrl:'assets/room_8.jpg',
      ),
      Room(
        number: 116,
        type: 'Single',
        price: 50,
        isAvailable: true,
        imageUrl: 'assets/room_9.jpg',
      ),
      Room(
        number: 117,
        type: 'single',
        price: 100,
        isAvailable: true,
        imageUrl: 'assets/room_10.jpg',
      ),
    ];
  }

  getBookings() {}
}
